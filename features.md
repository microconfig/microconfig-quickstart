# Features

### Meet the project
Let's imagine that this project contains multiple microservices, but we will focus on 2. Together they provide some generic payment functionality. One backend and one frontend.
Their current application configuration:

`payment-backend config for dev environent`
```yaml
name: payment-backend

server:
  port: 80
  context: /api
  
payment-gateway: http://gateway-mock.local

database:
  type: Postgres
  pool-size: 10
  url: jdbc:postgres://10.10.10.10:5432/payments
  
monitoring:
  base-path: /monitoring
  endpoints: info, health, prometheus
```

`payment-frontend config for dev`
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

monitoring:
  base-path: /monitoring
  endpoints: info, health, ready, prometheus
```

`payment-backend config for prod environent`
```yaml
name: payment-backend

server:
  port: 80
  context: /api
  
payment-gateway: http://payment-gateway.com

database:
  type: Postgres
  pool-size: 50
  url: jdbc:postgres://20.20.20.20:5432/payments
  
monitoring:
  base-path: /monitoring
  endpoints: info, health, prometheus
```

`payment-frontend config for prod`
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

monitoring:
  base-path: /monitoring
  endpoints: info, health, ready, prometheus
```

Let's migrate them to Microconfig.