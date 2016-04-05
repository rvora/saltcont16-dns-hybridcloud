{% set eth0_ip = grains['ip_interfaces']['eth0'][0] %}
{% set my_ip = grains.get('gce_external_ip', eth0_ip) %}

binddns:
  forwarders:
    - 8.8.8.8
    - 8.8.4.4
  zones:
    - create_db_only: False
      name: c.cloudopia.co
      contact: rajvor@cloudopia.co
      soa: ns1
      records:
        - owner: ns1
          class: A
          data: {{ my_ip }}
      mine_search: .*\.internal
      mine_func: internal_ip
      mine_dual_records: True
      mine_dual_func: external_ip
      mine_dual_prefix: ext-
      minion_id_replace:
      type: regex
        regex_list:
          - comment: aws
            pattern: '.*\.compute.internal$'
            repl: .aws.c.cloudopia.co
          - comment: gce
            pattern: '\.c\.[\w-]+\.internal$'
            repl: '\1.gce.c.cloudopia.co'
#        type: replace
#        replace_list:
#          - comment: ec2
#            from: .compute.internal
#            to: .aws.c.cloudopia.co
#          - comment: gce1
#            from: ".c."
#            to: "."
#          - comment: gce2
#            from: .internal
#            to: .gce.c.cloudopia.co
#          - comment: openstack1
#            from: .openstacklocal
#            to: .os.c.cloudopia.co
#          - comment: openstack2
#            from: .novalocal
#            to: .os.c.cloudopia.co
      zone_recs_from_mine: True

