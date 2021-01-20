# リファレンス / 環境変数
---

環境変数で指定可能なオプションの一覧。  
各項目の詳細は[リファレンス/プロファイル](../profile)を参照してください。  

--- 

### プロファイル関連

|プロファイル項目名| 環境変数 | 説明 | 
|----------------|---------| --- |
| - | `SAKURACLOUD_PROFILE` | 利用するプロファイルの名称 |
| - | `SAKURACLOUD_PROFILE_DIR` | プロファイル格納先ディレクトリ |
  
--- 

### APIキー関連

|プロファイル項目名| 環境変数 |
|----------------|---------|
| `AccessToken` | `SAKURACLOUD_ACCESS_TOKEN` |
| `AccessTokenSecret` | `SAKURACLOUD_ACCESS_TOKEN_SECRET` |
| `Zone` | `SAKURACLOUD_ZONE` |
| `Zones` | `SAKURACLOUD_ZONES` |
  
--- 

### Usacloudコマンド動作関連

|プロファイル項目名| 環境変数 |
|----------------|---------|
| `ArgumentMatchMode` | `SAKURACLOUD_ARGUMENT_MATCH_MODE` |
| `DefaultOutputType` | `SAKURACLOUD_DEFAULT_OUTPUT_TYPE` |
| `DefaultQueryDriver` | `SAKURACLOUD_DEFAULT_QUERY_DRIVER` |
| `ProcessTimeoutSec` | `SAKURACLOUD_PROCESS_TIMEOUT_SEC` |
  
--- 

### API動作関連

|プロファイル項目名| 環境変数 |
|----------------|---------|
| `AcceptLanguage` | `SAKURACLOUD_ACCEPT_LANGUAGE` |
| `RetryMax` | `SAKURACLOUD_RETRY_MAX` |
| `RetryWaitMax` | `SAKURACLOUD_RETRY_WAIT_MAX` |
| `RetryWaitMin` | `SAKURACLOUD_RETRY_WAIT_MIN` |
| `HTTPRequestTimeout` | `SAKURACLOUD_API_REQUEST_TIMEOUT` |
| `HTTPRequestRateLimit` | `SAKURACLOUD_API_REQUEST_RATE_LIMIT` |
| `APIRootURL` | `SAKURACLOUD_API_ROOT_URL` |
| `DefaultZone` | `SAKURACLOUD_DEFAULT_ZONE` |
  
--- 

### デバッグ関連

|プロファイル項目名| 環境変数 |
|----------------|---------|
| `TraceMode` | `SAKURACLOUD_TRACE` |
| `FakeMode` | `SAKURACLOUD_FAKE_MODE` |
| `FakeStorePath` | `SAKURACLOUD_FAKE_STORE_PATH` |
  
--- 
