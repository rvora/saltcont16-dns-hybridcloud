{%- set manu = salt['grains.get']('manufacturer', 'Unknown') -%}
mine_functions:
  network.ip_addrs: []
  internal_ip:
{% if manu == 'OpenStack Foundation' %}
    mine_function: grains.get
    key: os_internal_ip
{% elif manu == 'Google' %}
    mine_function: grains.get
    key: gce_internal_ip
{% endif %}
  external_ip:
{% if manu == 'OpenStack Foundation' %}
    mine_function: grains.get
    key: os_external_ip
{% elif manu == 'Google' %}
    mine_function: grains.get
    key: gce_external_ip
{% endif %}
