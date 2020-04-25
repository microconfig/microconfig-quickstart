# Microconfig Quickstart

## Example Repo

### Repository Description
This repository contains configuration example for 2 services:
* `payments-backend` 
* `payments-frontend`

Services are grouped into `payments` group.

Environment description contains 2 environments:
* `dev`
* `prod`

### Checkout Repository
```shell script
git clone https://github.com/microconfig/microconfig-quickstart.git
cd microconfig-quickstart
```

## Setup

### Download microconfig.jar 
Download the latest jar from [releases](https://www.google.com) and place it as `microconfig.jar` in `microconfig-quickstart` folder.  

### Install Java
Microconfig requires any Java SE JDK version 8 or higher. 

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