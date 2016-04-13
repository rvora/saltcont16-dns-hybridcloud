binddns:
  zones:
    - name: c.cloudopia.co
      contact: admin@cloudopia.co
      soa: ns1
      records:
        - owner: ns1
          class: A
          data: {{ grains.get('gce_external_ip') }}
	- owner: www.cloudopia.co
          class: A
          data: 53.42.124.5

      zone_recs_from_mine: True

      # primary records from mine from internal IP
      mine_search: .*\.openstacklocal|.*\.novalocal|.*\.internal|.*\.c\.cloudopia\.co
      mine_func: internal_ip

      # secondary records from mine from external IP
      mine_dual_records: True
      mine_dual_func: external_ip
      mine_dual_prefix: ext-

