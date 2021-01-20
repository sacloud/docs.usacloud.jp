package main

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"github.com/sacloud/libsacloud/v2/sacloud"
	"github.com/sacloud/libsacloud/v2/sacloud/profile"
	"github.com/sacloud/usacloud/pkg/cli"
	"github.com/sacloud/usacloud/pkg/cmd/core"
	"github.com/sacloud/usacloud/pkg/config"
	"github.com/sacloud/usacloud/pkg/test"
	"github.com/sacloud/usacloud/tools"
	"go/build"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"text/template"
)

const (
	destination = "/docs/references"
	templateFile = "../tools/template.tmpl"
)


func main() {
	if len(os.Args) != 2 {
		fmt.Println("Usage: gen-command-reference <BASE DIR>")
		os.Exit(1)
	}
	baseDir := os.Args[1]
	tmpl, err := ioutil.ReadFile(filepath.Join(baseDir, templateFile))
	if err != nil {
		panic(err)
	}

	ctx := tools.NewGenerateContext()
	for _ , resource := range ctx.Resources {
		config := &TemplateConfig{
			OutputPath:         filepath.Join(baseDir, destination, resource.Name + ".md"),
			Template:           string(tmpl),
			Parameter:          resource,
			PreventOverwriting: false,
			FuncMap: map[string]interface{}{
				"example": func(command *core.Command) string {
					parameter := command.ParameterInitializer()
					if eh, ok := parameter.(core.ExampleHolder); ok {
						return marshalIndent(eh.ExampleParameters(dummyCLIContext()))
					}
					return ""
				},
			},
		}
		WriteFileWithTemplate(config)
	}
}

func dummyCLIContext() cli.Context {
	return &test.DummyCLIContext{
		DummyValue: &test.DummyCLIContextValue{
			Context:      context.Background(),
			Option:       &config.Config{
				ConfigValue:       profile.ConfigValue{
					Zones: sacloud.SakuraCloudZones,
				},
			},
		},
	}
}

func marshalIndent(v interface{}) string {
	data, err := json.MarshalIndent(v, "", "    ")
	if err != nil {
		return ""
	}
	return string(data)
}

// TemplateConfig ソース生成を行うためのテンプレート設定
type TemplateConfig struct {
	OutputPath         string
	Template           string
	Parameter          interface{}
	PreventOverwriting bool
	FuncMap template.FuncMap
}

// WriteFileWithTemplate 指定の設定に従いファイル出力
func WriteFileWithTemplate(config *TemplateConfig) bool {
	buf := bytes.NewBufferString("")
	t := template.New("t").Funcs(config.FuncMap)
	template.Must(t.Parse(config.Template))
	if err := t.Execute(buf, config.Parameter); err != nil {
		log.Fatalf("writing output: %s", err)
	}

	// create dir
	if _, err := os.Stat(filepath.Dir(config.OutputPath)); err != nil && os.IsNotExist(err) {
		if err := os.MkdirAll(filepath.Dir(config.OutputPath), 0755); err != nil {
			log.Fatal(err)
		}
	}

	if config.PreventOverwriting {
		if _, err := os.Stat(config.OutputPath); err == nil {
			return false
		}
	}

	// write to file
	if err := ioutil.WriteFile(config.OutputPath, buf.Bytes(), 0644); err != nil {
		log.Fatalf("writing output: %s", err)
	}
	log.Printf("generated: %s\n", config.OutputPath)
	return true
}

// Gopath returns GOPATH
func Gopath() string {
	gopath := build.Default.GOPATH
	gopath = filepath.SplitList(gopath)[0]
	return gopath
}
