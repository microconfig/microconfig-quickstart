### Typical microservice configuration
Let's imagine that this project contains multiple microservices, but we will focus on 2. One backend and one frontend.
Their current configuration:

`payment-backend application config for dev`
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

`payment-frontend application config for dev`
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

`payment-backend deploy config for dev`
```yaml
image: "payment-backend:latest"

replicas: 1

ingress:
  host: http://payment-backend.local

probes:
  health: /monitoring/health
  ready: /monitoring/ready
```

`payment-frontend deploy config for dev`
```yaml
image: "payment-frontend:latest"

replicas: 1

ingress:
  host: http://payments.local

probes:
  health: /monitoring/health
  ready: /monitoring/ready
```

`payment-backend application config for prod`
```yaml
name: payment-backend

server:
  port: 80
  context: /api
  
payment-gateway: https://payment-gateway.com

database:
  type: Postgres
  pool-size: 50
  url: jdbc:postgres://20.20.20.20:5432/payments
  
monitoring:
  base-path: /monitoring
  endpoints: info, health, prometheus
```

`payment-frontend application config for prod`
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

`payment-backend deploy config for prod`
```yaml
image: "payment-backend:1.5"

replicas: 2

ingress:
  host: http://payment-backend.local

probes:
  health: /monitoring/health
  ready: /monitoring/ready
```

`payment-frontend deploy config for prod`
```yaml
image: "payment-frontend:2.1"

replicas: 3

ingress:
  host: https://payments.example.com

probes:
  health: /monitoring/health
  ready: /monitoring/ready
```

As you can see a lot of copy-paste. Some environment specific values and clear dependencies between services.

[Let's see what can we do about this](features.md)