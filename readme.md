# Microconfig Quickstart

### What you will learn
You will see how easy it is to install and use microconfig. 

### What you need
* Java Development Kit `JDK`. Any version 8 or higher. You can grab one [here](https://adoptopenjdk.net)
* (optional) `git` to checkout our example repo. 

## Example Configuration

### Description
Our configuration example has 2 services:
* `payments-backend` 
* `payments-frontend`

Services are combined into `payments` group.

Environment description contains 2 environments:
* `dev`
* `prod`

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
java -jar microconfig.jar -r . -e dev -s payments-backend

Filtered 1 component(s) in [dev] env.
Generated payments-backend/application.yaml

Generated [dev] configs in 221ms
```

Parameters: 
* `-r .` use the current directory as root folder
* `-e dev` generate for `dev` environment
* `-s payments-backend` generate for `payments-backend` service

As a result Microconfig created `build` folder with `dev` configs for `payments-backend`.
```
build
└── payments-backend
    └── application.yaml
```  

### Generate configuration for a group in a specific environment
Let's generate configuration for `payments` group in `prod` environment.

```shell script
java -jar microconfig.jar -r . -e prod -g payments

Filtered 2 component(s) in [prod] env.
Generated payments-backend/application.yaml
Generated payments-frontend/application.yaml

Generated [prod] configs in 254ms
```

Parameters: 
* `-r .` use the current directory as root folder
* `-e prod` generate for `prod` environment
* `-g payments` generate for `payments` group

As a result Microconfig created `build` folder with `prod` configs for `payments` group.
```
build
├── payments-backend
│   └── application.yaml
└── payments-frontend
    └── application.yaml
```  

### Generate configuration for all services in a specific environment
Let's generate configuration for all services in `dev` environment.

```shell script
java -jar microconfig.jar -r . -e dev

Filtered 2 component(s) in [dev] env.
Generated payments-backend/application.yaml
Generated payments-frontend/application.yaml

Generated [dev] configs in 320ms
```

Parameters: 
* `-r .` use the current directory as root folder
* `-e dev` generate for `dev` environment

As a result Microconfig created `build` folder with `dev` configs for all defined services.
```
build
├── payments-backend
│   └── application.yaml
└── payments-frontend
    └── application.yaml
```