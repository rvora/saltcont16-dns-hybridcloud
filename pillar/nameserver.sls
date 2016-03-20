{% set eth0_ip = grains['ip_interfaces']['eth0'][0] %}
{% set my_ip = grains.get('gce_external_ip', eth0_ip) %}

binddns:
  lookup:
    config:
      options:
        ip4_listen:
          - any
        ip6_listen:
          - ::1
        additional:
          - 'allow-query  { any; }'
          - 'recursion yes'
      named_conf:
        controls:
          - 'inet 127.0.0.1 port 953 allow { 127.0.0.1; } keys { "rndc-key"; };'
        logging_channels:
          - channel: simple_log
            desttype: file
            path: /var/log/named.log
            versions: 3
            size: 5m
            severity: info
            print_time: "yes"
            print_severity: "yes"
            print_category: "yes"
        logging_categories:
          - category: default
            channels:
              - simple_log
          - category: queries
            channels:
              - simple_log
    dnssec_validation: "no"
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
      zone_recs_from_mine: True

