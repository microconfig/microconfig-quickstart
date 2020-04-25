# Features by Example

### Simple Configuration Layout
You choose your configuration layout. You can group and organize your repository the way it makes sense for you.
Each folder with files is a named component and can used by Microconfig. Only requirement is that configuration should be somewhere in `components` folder.
```
components
├── payments
│   ├── payment-backend
│   │   └── application.yaml
│   └── payment-frontend
│       └── application.yaml
└── ...
│   ├── ...
│   │   └── ...
│   └── ...
│       └── ...
...
```

(more details in docs)

### Remove Copy-Paste
You can extract common parts of configuration to a dedicated component and reuse it via `#include`. 

(Button before/after)

`payment-backend`
```yaml
name: payment-backend

server:
  port: 80
  context: /api

payment-gateway: http://gateway-mock.local

database:
  pool-size: 10
  type: Postgres
  url: jdbc:postgres://10.10.10.10:5432/database

#include monitoring
```

`payment-frontend`
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