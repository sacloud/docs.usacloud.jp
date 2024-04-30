## 水平スケール時のサーバープランの指定例

### 通常プラン

```yaml
resources:
  - type: ServerGroup
    
    # ...中略...

    template: 
      # ...中略...
      
      plan:
        core: 2
        memory: 4
```

### コア占有プラン: Intel® Xeon® Processor

```yaml
resources:
  - type: ServerGroup

    # ...中略...

    template:
      # ...中略...

      plan:
        core: 2
        memory: 4
        dedicated_cpu: true
```

### コア占有プラン: AMD EPYC™ 7003 Series Processor

```yaml
resources:
  - type: ServerGroup
    zones: ["is1b"]

    # ...中略...

    template:
      # ...中略...

      plan:
        core: 32
        memory: 120
        dedicated_cpu: true
        cpu_model: amd_epyc_7713p
```

### GPUプラン

```yaml
resources:
  - type: ServerGroup
    zones: ["is1a"]

    # ...中略...

    template:
      # ...中略...

      plan:
        core: 4
        memory: 56
        gpu: 1
```
