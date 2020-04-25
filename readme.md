# Microconfig quick start

## Example repo

### Repository description
This repository contains configuration example for 2 services grouped into 1 `payments` group:
* `payments-backend` 
* `payments-frontend`

It supports 2 environments:
* `dev`
* `prod`

### Checkout repository
```shell script
git clone https://github.com/microconfig/microconfig-quickstart.git
cd microconfig-quickstart
```

## Setup

### Download microconfig.jar 
Download the latest jar from [releases](https://www.google.com) and place it as `microconfig.jar` in `microconfig-quickstart` folder.  

### Install Java
Microconfig requires any Java SE 8+ JDK. 

## Usage

### Generate configuration for a service in a specific environment
Let's generate configuration for `payments-backend` service in `dev` environment.

```shell script
java -jar microconfig.jar -r . -e dev -s payments-backend

Filtered 1 component(s) in [dev] env.
Generated payments-backend/application.yaml

Generated [dev] configs in 221ms
```

Here parameters mean: 
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

Here parameters mean: 
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

### Generate configuration for all services in specific environment
Let's generate configuration for all services in `dev` environment.

```shell script
java -jar microconfig.jar -r . -e dev

Filtered 2 component(s) in [dev] env.
Generated payments-backend/application.yaml
Generated payments-frontend/application.yaml

Generated [dev] configs in 320ms
```

Here parameters mean: 
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