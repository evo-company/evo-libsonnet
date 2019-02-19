## Prerequisites

```bash
go get github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb
```

## Install

```bash
cd ks-app
jb init
jb install https://github.com/evo-company/evo-libsonnet
```

## Usage

```jsonnet
local istio = import "evo-libsonnet/istio.libsonnet";

local Gateway = istio.networking.v1alpha3.gateway;

[
  Gateway.new("test"),
]
```
