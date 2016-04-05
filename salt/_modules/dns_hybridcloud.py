
def fqdn():
    fqdn_dict = {}
    fqdn_dict['domain'] = 'cld.cloudopia.co'
    fqdn_dict['dept'] = __salt__['grains.get']('dept', 'UnknownDept')
    fqdn_dict['appl'] = __salt__['grains.get']('application', 'UnknownApplication')
    fqdn_dict['role'] = __salt__['grains.get']('role', 'UnknownRole')
    fqdn_dict['instance'] = __salt__['grains.get']('instance', 'UnknownInstance')

    return '%(instance)s.%(role)s.%(appl)s.%(dept)s.%(domain)s' % fqdn_dict
