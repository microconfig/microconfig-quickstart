# Features by Example

```
Every feature should have a link to docs
and have a button "before after" to flip raw code and microconfig version
```

### Simple Configuration Layout
You choose your configuration layout. You can group and organize your repository the way it makes sense for you.
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


### Reuse Common Parts
You can extract common parts of configuration to a dedicated component and reuse it with `#include`. 

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

payment-backend:
  host: http://payment-backend.local
  path: /api
  timeoutMs: 180000

#include monitoring
```

`monitoring`
```yaml
monitoring:
  base-path: /monitoring
  endpoints: info, health, ready, prometheus
```

### Reference Values
You can reference a value from current or another component with `${place@holder}`.

`payment-backend`
```yaml
name: payment-backend

server:
  port: 80
  context: /api
  
payment-gateway: http://gateway-mock.local

database:
  type: Postgres
  pool-size: 10
  url: jdbc:postgres://10.10.10.10:5432/database
  
monitoring:
  base-path: /monitoring
  endpoints: info, health, prometheus
```

`payment-frontend`
```yaml
name: payment-frontend

server:
  port: 80
  
payment-backend: 
  host: http://payment-backend.local
  path: ${payment-backend@server.context}
  timeoutMs: 180000

monitoring:
  base-path: /monitoring
  endpoints: info, health, ready, prometheus
```

### Dynamic Values
You can use `#{expression+language}` to dynamically generate your values. It supports math operations and much more. 

`payment-frontend`
```yaml
name: payment-frontend

server:
  port: 80
  
payment-backend: 
  host: http://payment-backend.local
  path: /api
  timeoutMs: #{ 3 * 60 * 1000 }

monitoring:
  base-path: /monitoring
  endpoints: info, health, ready, prometheus
```

### Environment Specific Config
You can have `.env.` specific values for each environment you need. They will be merged with your base configuration.

`payment-backend/application.dev.yaml`
```yaml
payment-gateway: http://gateway-mock.local

database:
  url: jdbc:postgres://10.10.10.10:5432/database
```

`payment-backend/application.prod.yaml`
```yaml
payment-gateway: https://payment-gateway.com

database:
  pool-size: 50
  url: jdbc:postgres://20.20.20.20:5432/database
```

`payment-backend/application.yaml`
```yaml
name: payment-backend

server:
  port: 80
  context: /api
  
database:
  type: Postgres
  pool-size: 10
  
monitoring:
  base-path: /monitoring
  endpoints: info, health, prometheus
```

### Static Files Templating
You can use static templates and populate them with data unique for each service.

`log template.xml`
```xml
<configuration>
    <appender class="ch.qos.logback.core.FileAppender">
        <file>logs/${this@name}.log</file>
            <encoder>
                <pattern>%d{HH:mm:ss.SSS} %-5level %logger{15} %msg %n</pattern>
            </encoder>
    </appender>    
</configuration>
```

`payment-backend`
```yaml
microconfig.template.log:
  fromFile: ${log@configDir}/template.xml
  toFile: logback.xml

name: payment-backend

server:
  port: 80
  context: /api
  
payment-gateway: http://gateway-mock.local

database:
  type: Postgres
  pool-size: 10
  url: jdbc:postgres://10.10.10.10:5432/database
  
monitoring:
  base-path: /monitoring
  endpoints: info, health, prometheus
```

`payment-backend logback.xml`
```xml
<configuration>
    <appender class="ch.qos.logback.core.FileAppender">
        <file>logs/payment-backend.log</file>
            <encoder>
                <pattern>%d{HH:mm:ss.SSS} %-5level %logger{15} %msg %n</pattern>
            </encoder>
    </appender>    
</configuration>
```

### Config Diff
You can generate git style `diff` and see how your configuration changes overtime or compare points in time.

`payment-frontend before`
```yaml
name: payment-frontend

monitoring:
  base-path: /monitoring
  endpoints: info, health, ready, prometheus

payment-backend:
  host: http://payment-backend.local
  path: /api

server:
  maxThreads: 100
  minThreads: 10
  port: 80
  timeoutMs: 180000
```  

`payment-frontend now`
```yaml
name: payment-frontend

monitoring:
  base-path: /monitoring
  endpoints: info, health, ready, prometheus

payment-backend:
  host: https://payment-backend.local
  path: /api
  timeoutMs: 180000

server:
  port: 80
```

`payment-frontend diff`
```yaml
+payment-backend:
  timeoutMs: 180000

-server:
  maxThreads: 100
  minThreads: 10
  timeoutMs: 180000

payment-backend:
  host: http://payment-backend.local -> https://payment-backend.local
```