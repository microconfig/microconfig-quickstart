# Features by Example

### Simple Directory Structure
You choose your configuration layout. The only requirement is that configuration should be somewhere in `components` folder.
You can group and organize folders the way it makes sense for you. Each folder with files is a named component and can be used to store configuration. 

```
components
├── payments
│   ├── payments-backend
│   └── payments-frontend
└── others
    ├── other-service-1
    └── other-service-2
...
```

### Remove Copy-Paste
You can extract common parts of configuration to a dedicated component and reuse it via `#include`. 

(Button before/after)

`payments-backend`
```yaml
name: payment-backend

server:
  port: 80
  context: /api

payment-gateway: http://gateway-mock.local

database:
  pool-size: 10
  type: Postgres
  url: jdbc:postgres://10.10.10.10:5432/payments

#include monitoring
```

`payments-frontend`
```yaml
name: payment-frontend

server:
  port: 80
  timeout: 180000
  minThreads: 10
  maxThreads: 100

payment-backend:
  host: http://payment-backend.local
  path: /api

#include monitoring
```

`monitoring`
```yaml
monitoring:
  base-path: /monitoring
  endpoints: info, health, ready, prometheus
```