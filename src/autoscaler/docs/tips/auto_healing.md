## 水平スケールでの台数維持機能

水平スケール(ServerGroup)において台数維持機能が利用可能です。  
台数維持機能は水平スケール対象のサーバに対しヘルスチェックを実行し、異常と判断されたサーバを自動的に削除し、新しいサーバを作成する機能です。

### 台数維持機能の利用方法

ServerGroupリソースの`auto_healing`セクションで台数維持機能を有効化します。

```yaml
resources:
  - type: ServerGroup
    
    # (中略)

    auto_healing:
      enabled: true #台数維持機能の有効化    
```

この状態で`Keep`操作をするとヘルスチェックが実施され、異常と判断されたサーバが削除され、新しいサーバが作成されます。
※ Keep操作は[Direct Inputs](../../inputs/direct)でのみサポートされています。

```bash
$ autoscaler inputs direct keep
```

### ヘルスチェックの仕様

- IaaS APIを利用してサーバの状態を確認します。
    - 電源状態がON以外の場合は異常と判断します。
     
- ServerGroupリソースのparentが指定されており、かつparentがLoadBalander、またはEnhancedLoadBalancerの場合、parentのヘルスチェック結果も参照します。
    - LoadBalancerの場合、指定されたVIPとポート番号に合致する実サーバのヘルスチェック結果を参照します。
    - ELBの場合、指定されたポート番号に合致する実サーバへのヘルスチェック結果を参照します。

### その他注意点

- Keep操作時のcooldownはUp/Down操作と共通のタイマーを用います。必要に応じてcooldownやUp/Doun/Keepの操作時間の間隔を調整してください。
- Up/Down操作と同じく、Up/Down/Keep操作中は別の処理を起動できません。