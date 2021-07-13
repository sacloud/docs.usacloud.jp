# アーキテクチャ

sacloud/autoscalerは以下の3つのコンポーネントから構成されています。

- Inputs: 何らかのイベントを受け、Coreへスケーリングリクエストを送信する
- Core: Inputsからのリクエストを受け、定義されたリソースの状態を読み取りあるべき状態を算出、Handlersへ指示を出す
- Handlers: Coreからの指示を受けさくらのクラウド上のリソースを操作する

InputsとCore、CoreとHandlersのやりとりにはgRPCを利用しています。  
InputsとHandlersについては各protoファイルに沿って独自のgRPCクライアント/サーバを実装可能です。

- Inputs 〜 Core: [request.proto](https://github.com/sacloud/autoscaler/blob/main/protos/request.proto)
- Core 〜 Handlers [handler.proto](https://github.com/sacloud/autoscaler/blob/main/protos/handler.proto)
