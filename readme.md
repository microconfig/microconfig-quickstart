# Quickstart

## What you will learn

You will see how to install Microconfig, organize config layout and build configuration. 

## What you need

* Java Development Kit `JDK`. Any version 8 or higher. You can grab one [here](https://adoptopenjdk.net)
* (optional) `git` to checkout our example repo. 

## Example Configuration

Our configuration example has 2 services:
* `payments-backend` 
* `payments-frontend`

Services are combined into `payments` group.

We have environment specific values for 2 environments:
* `dev`
* `prod`

Each service needs 3 files:
* `application.yaml` - application config 
* `deploy.yaml` - deployment config
* `logback.xml` - logging configuration

## Setup

### Example repository

Checkout with `git`
```shell script
git clone https://github.com/microconfig/microconfig-quickstart.git
cd microconfig-quickstart
```

Or just [download](https://github.com/microconfig/microconfig-quickstart/archive/master.zip) and unzip it directly.


### microconfig.jar 
[Download](https://github.com/microconfig/microconfig/releases) the latest jar from releases and place it as `microconfig.jar` in `microconfig-quickstart` folder. You're done :) 

## Usage

### Generate configuration for a service in a specific environment
Let's generate configuration for `payments-backend` service in `dev` environment.

```shell script
java -jar microconfig.jar -r . -e dev -s payment-backend

Filtered 1 component(s) in [dev] env.
Copied 'payment-backend' template ../log/logback.xml -> logback.xml
Generated payment-backend/application.yaml
Generated payment-backend/deploy.yaml

Generated [dev] configs in 265ms
```

Parameters: 
* `-r .` use the current directory as root folder
* `-e dev` generate for `dev` environment
* `-s payments-backend` generate for `payments-backend` service

As a result Microconfig created `build` folder with `dev` configs for `payments-backend`.
```
build
└── payment-backend
    ├── application.yaml
    ├── deploy.yaml
    └── logback.xml
```  

### Generate configuration for a group in a specific environment
Let's generate configuration for `payments` group in `prod` environment.

```shell script
java -jar microconfig.jar -r . -e prod -g payments

Filtered 2 component(s) in [prod] env.
Copied 'payment-backend' template ../log/logback.xml -> logback.xml
Copied 'payment-frontend' template ../log/logback.xml -> logback.xml
Generated payment-backend/application.yaml
Generated payment-backend/deploy.yaml
Generated payment-frontend/application.yaml
Generated payment-frontend/deploy.yaml

Generated [prod] configs in 325ms
```

Parameters: 
* `-r .` use the current directory as root folder
* `-e prod` generate for `prod` environment
* `-g payments` generate for `payments` group

As a result Microconfig created `build` folder with `prod` configs for `payments` group.
```
build
├── payment-backend
│   ├── application.yaml
│   ├── deploy.yaml
│   └── logback.xml
└── payment-frontend
    ├── application.yaml
    ├── deploy.yaml
    └── logback.xml
```  

### Generate configuration for all services in a specific environment
Let's generate configuration for all services in `dev` environment.

```shell script
java -jar microconfig.jar -r . -e dev

Filtered 2 component(s) in [dev] env.
Copied 'payment-frontend' template ../log/logback.xml -> logback.xml
Copied 'payment-backend' template ../log/logback.xml -> logback.xml
Generated payment-backend/application.yaml
Generated payment-backend/deploy.yaml
Generated payment-frontend/application.yaml
Generated payment-frontend/deploy.yaml

Generated [dev] configs in 326ms
```

Parameters: 
* `-r .` use the current directory as root folder
* `-e dev` generate for `dev` environment

As a result Microconfig created `build` folder with `dev` configs for all defined services.
```
build
├── payment-backend
│   ├── application.yaml
│   ├── deploy.yaml
│   └── logback.xml
└── payment-frontend
    ├── application.yaml
    ├── deploy.yaml
    └── logback.xml
```

## Conclusion

We hope you agree that microconfig is easy to use. Now you can explore current example to see Microconfig syntax.
Also, you can try out [Microconfig plugin](https://microconfig.io/plugin.html) if you have [IntelliJ IDEA](https://www.jetbrains.com/idea/download/) or any other JetBrains IDE installed.