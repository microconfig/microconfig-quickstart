# Features by Example

### Simple directory structure
You choose your configuration layout. The only requirement is that configuration should be somewhere in `components` folder. 
Each sub-folder is considered a named component and can be used to store configuration. 
So let's create folders for each of our services and place current `dev` application configuration in them.
 
```
components
├── payments-backend
│   └── application.yaml
└── payments-frontend
    └── application.yaml
```

### Remove Copy-Paste
You can extract common parts of configuration to a dedicated component and reuse it via `#include`. So let's extract monitoring configuration. 
We create `components/common/monitoring` folder and create an `application.yaml` file in it.
```
components
├── common
│   └── monitoring
│       └── application.yaml
├── payments-backend
│   └── application.yaml
└── payments-frontend
    └── application.yaml
```

This allows us to move monitoring configuration part in a named component `monitoring` and `#include` it in our services.
(Button before/after)

`monitoring`
```yaml
monitoring:
  base-path: /monitoring
  endpoints: info, health, ready, prometheus
```

`payments-backend`
```yaml
#include monitoring

name: payment-backend

server:
  port: 80
  context: /api

payment-gateway: http://gateway-mock.local

database:
  pool-size: 10
  type: Postgres
  url: jdbc:postgres://10.10.10.10:5432/payments 
```

`payments-frontend`
```yaml
#include monitoring

name: payment-frontend

server:
  port: 80
  timeout: 180000
  minThreads: 10
  maxThreads: 100

payment-backend:
  host: http://payment-backend.local
  path: /api
```