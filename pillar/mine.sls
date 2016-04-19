
mine_functions:
  # just for fun, we don't use this
  network.ip_addrs: []
  # we only use ip addresses found using cloud API
  internal_ip:
    mine_function: binddns.internal_cloud_ip
    corp_suffix:   c.cloudopia.co
  external_ip:
    mine_function: binddns.external_cloud_ip
    corp_suffix:   c.cloudopia.co


