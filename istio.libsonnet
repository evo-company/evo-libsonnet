{
  networking:: {
    v1alpha3:: {
      local apiVersion = { apiVersion: 'networking.istio.io/v1alpha3' },
      gateway:: {
        local kind = { kind: 'Gateway' },
        new(name):: apiVersion + kind + self.mixin.metadata.withName(name),
        mixin:: {
          metadata:: {
            local __metadataMixin(metadata) = { metadata+: metadata },
            withName(name):: self + __metadataMixin({ name: name }),
          },
          spec:: {
            local __specMixin(spec) = { spec+: spec },
            withSelector(selector):: self + __specMixin({selector: selector}),
            withServers(servers):: self + if std.type(servers) == 'array' then __specMixin({servers: servers}) else __specMixin({servers: [servers]}),
            Server:: hidden.networking.v1alpha3.Server,
          },
        },
      },
      virtualservice:: {
        local kind = { kind: 'VirtualService' },
        new(name):: apiVersion + kind + self.mixin.metadata.withName(name),
        mixin:: {
          metadata:: {
            local __metadataMixin(metadata) = { metadata+: metadata },
            withName(name):: self + __metadataMixin({ name: name }),
          },
          spec:: {
            local __specMixin(spec) = { spec+: spec },
            withHosts(hosts):: self + __specMixin({hosts: hosts}),
            withGateways(gateways):: self + if std.type(gateways) == 'array' then __specMixin({gateways: gateways}) else __specMixin({gateways: [gateways]}),
            withHTTP(http):: self + if std.type(http) == 'array' then __specMixin({http: http}) else __specMixin({http: [http]}),
            HTTPRoute:: hidden.networking.v1alpha3.HTTPRoute,
          },
        },
      },
      destinationrule:: {
        local kind = { kind: 'DestinationRule' },
        new(name, host):: apiVersion + kind + self.mixin.metadata.withName(name) + self.mixin.spec.withHost(host),
        mixin:: {
          metadata:: {
            local __metadataMixin(metadata) = { metadata+: metadata },
            withName(name):: self + __metadataMixin({ name: name }),
          },
          spec:: {
            local __specMixin(spec) = { spec+: spec },
            withHost(host):: self + __specMixin({host: host}),
            withSubsets(subsets):: self + __specMixin({subsets: subsets}),
            Subset:: hidden.networking.v1alpha3.Subset,
          },
        },
      },
    },
  },
  local hidden = {
    networking:: {
      v1alpha3:: {
        Server:: {
          new():: self,
          withPort(port):: self + {port: port},
          withHosts(hosts):: self + {hosts: hosts},
          Port:: hidden.networking.v1alpha3.Port,
        },
        Port:: {
          new(number, protocol):: self + {number: number, protocol: protocol},
          withName(name):: self + {name: name},
        },
        HTTPRoute:: {
          new():: self,
          withRoute(route):: self + {route: route},
          withMatch(match):: self + {match: match},
          HTTPMatchRequest:: hidden.networking.v1alpha3.HTTPMatchRequest,
          DestinationWeight:: hidden.networking.v1alpha3.DestinationWeight,
        },
        HTTPMatchRequest:: {
          new():: self,
          withUri(match):: self + {uri: match},
          withScheme(match):: self + {scheme: match},
          withMethod(match):: self + {method: match},
          withAuthority(match):: self + {authority: match},
          withHeader(name, match):: self + {[name]: match},
          withPort(port):: self + {port: port},
          StringMatch:: hidden.networking.v1alpha3.StringMatch,
        },
        DestinationWeight:: {
          new(destination, weight=100):: {weight: weight, destination: destination},
          Destination:: hidden.networking.v1alpha3.Destination,
        },
        Destination:: {
          new(host):: self + {host: host},
          withSubset(subset):: self + {subset: subset},
          withPortSelector(port):: self + {port: port},
          PortSelector:: hidden.networking.v1alpha3.PortSelector,
        },
        PortSelector:: {
          new(number):: {number: number},
        },
        Subset:: {
          new(name, labels):: {name: name, labels: labels},
        },
        StringMatch:: {
          exact(value):: {exact: value},
          prefix(value):: {prefix: value},
          regex(value):: {regex: value},
        },
      },
    },
  },
}
