# Features by Example

```
Every feature should have a link to docs
and have a button "before after" to flip raw code and microconfig version
```

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


### Remove Copy-Paste
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

### Reference a config value from another service
You can reference a specific value from other component with `${place@holder}`. This allows you to remove copy-paste and have 
clear dependencies in your configuration. You can reference other components with `${component-name@foo.bar}` 
or you can even reference current component with `${this@foo.bar}`.

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

### Dynamic config values
You can use rich `#{expression+language}` to dynamically generate your values. It supports math operations and much more. 
In this example we have `payment-backend.timeoutMs` which is 3 minutes in milliseconds, let's calculate this value with expression 
making it easier to understand.

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
