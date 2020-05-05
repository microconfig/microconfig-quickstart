# Features by Example
This guide describes how Microconfig can help to solve common microcservice configuration problems. 
More details you can find in [Documentation](https://microconfig.io/documentation.html).

## Simple Configuration Layout

### Problem
Other configuration frameworks can demand a specific configuration folder structure or specific filenames.

### Solution
Microconfig only asks you to create folders for your services somewhere in `components` folder. 
You choose the names and folder structure. If you have different types of configuration just place them in the same service folder. 

```
components
├── payments
│   ├── payment-backend
│   │   └── application.yaml
│   │   └── values.deploy
│   └── payment-frontend
│       └── application.yaml
│       └── values.deploy
└── ...
...
```

## Reuse Common Parts

### Problem
Microservices have a lot of shared configuration parts that is copy-pasted between them. So you need to go through all services
one by one to update this shared part.

### Solution
Microconfig allows you to extract common parts of configuration to a dedicated component and reuse it with `#include`.
This way service config is more focused on unique parts and all common parts are just included. In this case if you need
to update your common part you just do it in one place and everyone gets this update via `#include`. 

`payment-backend`
```yaml
#include monitoring

server:
  port: 8080
  context: /api

...
```

`payment-frontend`
```yaml
#include monitoring

payment-backend:
  host: http://payment-backend.local

...
```

`monitoring`
```yaml
monitoring:
  base-path: /monitoring
  endpoints: info, health, ready, prometheus
```

## Reference Values

### Problem
Different services can depend on each other's configuration keys. For example frontend needs backend's api base path. 
You can just keep this value in two places but in this case you need to remember about this dependency and update them both.  

### Solution
Microconfig can reference a value from current or another component with a `${placeholder}`. This allows you to keep values
only in original services and all who depend on them can just have an explicit reference. In this case you need to update 
the value only once.

`payment-backend`
```yaml
name: payment-backend

server:
  context: /api
  port: 8080
  
...
```

`payment-frontend`
```yaml
  
payment-backend: 
  path: ${payment-backend@server.context}

...
```

## Dynamic Values

### Problem
Sometimes static values are not enough, and you want to do a `+1` or `base64`. Some values even are more readable as expressions.    

### Solution
Microconfig has `#{'expression' + 'language'}` to dynamically generate your values. It supports math operations and much more. 

`payment-frontend`
```yaml
name: #{'${this@name}'.toUpperCase()}

payment-backend: 
  timeoutMs: #{ 3 * 60 * 1000 }

...
```

## Environment Specific Config

### Problem
We deploy to different environments that have specific properties. Your production database has different ip address than your dev.
All of those specifications should be applied to final version for your environment.    

### Solution
Microconfig supports specific values for each environment you need. You just create an override `.env.` file near your base configuration.
In this file you specify all that you want for your `env` and it will be merged with your base configuration. 
More specific values will override base ones.

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

database:
  type: Postgres
  pool-size: 10
  
...
```

## Static Files Templating

### Problem
Your services usually require some additional 3rd party configuration files like a log configuration or a deploy script.
It's easy if these files are same for everyone but what if they need to change a bit for each service or environment?    

### Solution
Microconfig can use static templates and populate them with data unique for each service via placeholders. So you can 
keep your template in one place and then generate specific result for each service. 

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

...
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

## Config Diff

### Problem
When you have your configuration in some kind of templating engine it might be difficult to keep track of changes or
compare different versions of configuration. For example, before new deployment to production you want to know what changed
in your configuration.     

### Solution
Microconfig allows you to generate git style `diff` and see how your configuration changes overtime or compare different versions.

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