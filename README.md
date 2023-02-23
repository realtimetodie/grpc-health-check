# grpc-health-check

A minimal, safe and high performance command line tool for gRPC health checking

## About

Exits with a status of 0 (true) or 1 (false), depending on the evaluation of the gRPC health checking status.

[![CI](https://github.com/realtimetodie/grpc-health-check/workflows/CI/badge.svg?branch=main)](https://github.com/realtimetodie/grpc-health-check/actions)

## Documentation

* [Official documentation](https://github.com/grpc/grpc/blob/master/doc/health-checking.md)

## Usage

```sh
$ grpc-health-check [FLAGS] [OPTIONS]
```

Example

```sh
$ grpc-health-check --port 5400
```

## Installation

### Kubernetes

```yaml
spec:
  containers:
  - name: server
    image: ...
    ports:
    - containerPort: 5400
    readinessProbe:
      exec:
        command: ["grpc-health-check", "--port=5400"]
      initialDelaySeconds: 2
    livenessProbe:
      exec:
        command: ["grpc-health-check", "--port=5400"]
      periodSeconds: 1 // Run the health-check once every second
      initialDelaySeconds: 4
```

### Bazel support

The command line tool can be built from source and added to a container image using the [Bazel](https://bazel.build/) build tool.

WORKSPACE

```starlark
http_archive(
    name = "grpc_health_check",
    sha256 = "23371fdf00af99cabb8ec69eaf34013c283a209a2eebadc27f89e08018ac3af0",
    strip_prefix = "grpc-health-check-2a7b4badab1044afbbde8fc63d15d80965734f75",
    urls = [
        "https://github.com/realtimetodie/grpc-health-check/archive/2a7b4badab1044afbbde8fc63d15d80965734f75.tar.gz",
    ],
)

load(
    "@grpc_health_check//:defs.bzl",
    "grpc_health_check_crate_repositories",
    "grpc_health_check_repositories",
)

grpc_health_check_repositories()

grpc_health_check_crate_repositories()
```

BUILD.bazel

```
load("@io_bazel_rules_docker//container:container.bzl", "container_layer")

container_layer(
    name = "grpc_health_check_container_layer",
    directory = "/usr/bin",
    files = ["@grpc_health_check//:binary"],
)
```

## Flags

**--help**, **-h**

Prints help information.

**--version**, **-V**

Prints version information.

**--verbose**

Enable verbose mode.

## Options

**--address**=*address*

Address to the gRPC server (default *localhost*).

**--config**=*config*

File path to the YAML configuration file.

**--port**=*port*

Port to the gRPC server.

**--rpc-timeout**=*rpc-timeout*

Timeout for establishing connection in milliseconds (ms) (default *1500*).

**--service-name**=*service-name*

Name of the service to check (default *""*). An empty string is the default value, according to the gRPC Health Check Protocol specification.

**--stream**=*true|false*

Enable RPC streaming mode (default *false*).

**--tls-ca-cert**=*tls-ca-cert*

File path to the CA certificate against which to verify the server's certificate.

**--tls-client-cert**=*tls-client-cert*

File path to the client's certificate.

**--tls-client-key**=*tls-client-key*

File path to the client's private key.

**--tls-domain-name**=*tls-domain-name*

Name of the domain against which to verify the server's certificate.

**--user-agent**=*user-agent*

Name of the user agent.

## Configuration

YAML

```yaml
address: ""
port: integer
rpc_timeout: integer
service_name: ""
stream: true|false
tls_ca_cert: ""
tls_client_cert: ""
tls_client_key: ""
tls_domain_name: ""
user_agent: ""
```
