## Flags

| Flag / Environment Variable                    | Required | Default    | Description                                          |
| --------------------------------------------   | -------- | ---------- | -------------------------                            |
| `--token` / `SAKURACLOUD_ACCESS_TOKEN`         | ◯        |            | API Key(Token)                                       |
| `--secret` / `SAKURACLOUD_ACCESS_TOKEN_SECRET` | ◯        |            | API Key(Secret)                                      |
| `--ratelimit`/ `SAKURACLOUD_RATE_LIMIT`        |          | `5`        | API request rate limit(maximum:10)                   |
| `--webaddr` / `WEB_ADDR`                       |          | `:9542`    | Exporter's listen address                            |
| `--webpath`/ `WEB_PATH`                        |          | `/metrics` | Metrics request path                                 |
| `--no-collector.auto-backup`                   |          | `false`    | Disable the AutoBackup collector                     |
| `--no-collector.coupon`                        |          | `false`    | Disable the Coupon collector                         |
| `--no-collector.database`                      |          | `false`    | Disable the Database collector                       |
| `--no-collector.esme`                          |          | `false`    | Disable the ESME collector                           |
| `--no-collector.internet`                      |          | `false`    | Disable the Internet(Switch+Router) collector        |
| `--no-collector.load-balancer`                 |          | `false`    | Disable the LoadBalancer collector                   |
| `--no-collector.local-router`                  |          | `false`    | Disable the LocalRouter collector                    |
| `--no-collector.mobile-gateway`                |          | `false`    | Disable the MobileGateway collector                  |
| `--no-collector.nfs`                           |          | `false`    | Disable the NFS collector                            |
| `--no-collector.proxy-lb`                      |          | `false`    | Disable the ProxyLB(Enhanced LoadBalancer) collector |
| `--no-collector.server`                        |          | `false`    | Disable the Server collector                         |
| `--no-collector.sim`                           |          | `false`    | Disable the SIM collector                            |
| `--no-collector.vpc-router`                    |          | `false`    | Disable the VPCRouter collector                      |
| `--no-collector.zone`                          |          | `false`    | Disable the Zone collector                           |
