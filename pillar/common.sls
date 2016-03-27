{% from "binddns_lookup.jinja" import binddns_lookup with context %}

mine_functions:
  network.ip_addrs: []
  internal_ip:
    mine_function: grains.get
    key: {{ binddns_lookup.internal_ip }}
  external_ip:
    mine_function: grains.get
    key: {{ binddns_lookup.external_ip }}
