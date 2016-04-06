
{% from "cloud_lookup.jinja" import 
   cloud_lookup with context %}

mine_functions:
  # just for fun, we don't use this
  network.ip_addrs: []
  ip_cloud:
    mine_function: binddns.ip_cloud
    corp: c.acme.com
  # we only use ip addresses found using cloud API
  internal_ip:
    mine_function: grains.get
    key: {{ cloud_lookup.internal_ip }}
  external_ip:
    mine_function: grains.get
    key: {{ cloud_lookup.external_ip }}


