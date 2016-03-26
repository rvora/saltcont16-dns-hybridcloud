{% set eth0_ip = grains['ip_interfaces']['eth0'][0] %}
{% set my_ip = grains.get('gce_external_ip', eth0_ip) %}

binddns:
  forwarders:
    - 8.8.8.8
    - 8.8.4.4
  zones:
    - create_db_only: False
      name: saltconf16.cld.cloudopia.co
      refresh: 1200
      retry: 180
      expire: 2419200
      minimum: 60
      contact: rajvor@cloudopia.co
      soa: ns1
#TODO: compute serial in jinja, if possible
      serial: {{ salt['grains.get']('bind_serial', '201408141428') }}
      additional:
        - update-policy { grant rndc-key zonesub ANY; }
      records:
        - owner: ns1
          ttl: 300
          class: A
          data: {{ my_ip }}
      mine_search: .*\.internal
      mine_func: internal_ip
      minion_id_replace:
        - comment: gce
          from: .internal
          to: .saltconf16.cld.cloudopia.co
      zone_recs_from_mine: True

