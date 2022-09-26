locals {
  defaults   = lookup(var.model, "defaults", {})
  modules    = lookup(var.model, "modules", {})
  intersight = lookup(var.model, "intersight", {})
  orgs       = var.orgs
  profiles   = lookup(local.intersight, "profiles", {})
  domain_profiles = local.modules.profiles.domain == true ? {
    for v in lookup(local.profiles, "domain", []) : v.name => {
      name                        = v.name
      network_connectivity_policy = lookup(v, "network_connectivity_policy", "")
      ntp_policy                  = lookup(v, "ntp_policy", "")
      port_policies               = lookup(v, "port_policies", [])
      serial_numbers              = lookup(v, "serial_numbers", [])
      snmp_policy       = lookup(v, "snmp_policy", "")
      switch_control_policy       = lookup(v, "switch_control_policy", "")
      syslog_policy               = lookup(v, "syslog_policy", "")
      system_qos_policy           = lookup(v, "system_qos_policy", "")
      vlan_policies               = lookup(v, "vlan_policies", [])
      vsan_policies               = lookup(v, "vsan_policies", [])
    }
  } : {}
  switch_profiles_loop = local.modules.profiles.domain == true ? flatten([
    for v in local.domain_profiles : [
      for s in ["A", "B"] : {
        moid = module.domain[v.name]["domain_profile"][s]
        name                        = "${v.name}-${s}"
        network_connectivity_policy = lookup(v, "network_connectivity_policy", "")
        ntp_policy                  = lookup(v, "ntp_policy", "")
        port_policy = s == "A" && length(
          v.port_policies) > 0 ? element(v.port_policies, 0
          ) : s == "B" && length(v.port_policies) > 1 ? element(v.port_policies, 1) : s == "B" && length(
          v.port_policies) > 0 ? element(v.port_policies, 0
        ) : ""
        snmp_policy = lookup(v, "snmp_policy", "")
        serial_number = s == "A" && length(
          v.serial_numbers) > 0 ? element(v.serial_numbers, 0
          ) : s == "B" && length(v.serial_numbers) > 1 ? element(v.serial_numbers, 1) : s == "B" && length(
          v.serial_numbers) > 0 ? element(v.serial_numbers, 0
        ) : ""
        switch_control_policy = lookup(v, "switch_control_policy", "")
        syslog_policy         = lookup(v, "syslog_policy", "")
        system_qos_policy     = lookup(v, "system_qos_policy", "")
        vlan_policy = s == "A" && length(
          v.vlan_policies) > 0 ? element(v.vlan_policies, 0
          ) : s == "B" && length(v.vlan_policies) > 1 ? element(v.vlan_policies, 1) : s == "B" && length(
          v.vlan_policies) > 0 ? element(v.vlan_policies, 0
        ) : ""
        vsan_policy = s == "A" && length(
          v.vsan_policies) > 0 ? element(v.vsan_policies, 0
          ) : s == "B" && length(v.vsan_policies) > 1 ? element(v.vsan_policies, 1) : s == "B" && length(
          v.vsan_policies) > 0 ? element(v.vsan_policies, 0
        ) : ""
      }
    ]
  ]) : []
  switch_profiles = { for v in local.switch_profiles_loop : v.name => v }
}

#____________________________________________________________
#
# Intersight UCS Domain Cluster Profile Resource
# GUI Location: Profiles > UCS Domain Profile > Create
#____________________________________________________________

module "domain" {
  source  = "terraform-cisco-modules/profiles-domain/intersight"
  version = ">= 1.0.4"
  for_each = {
    for dp in lookup(local.profiles, "domain", []) : dp.name => dp if lookup(local.modules.profiles, "domain", true)
  }
  action              = lookup(each.value, "action", local.defaults.intersight.profiles.domain.action)
  description         = lookup(each.value, "description", "")
  domain_src_template = lookup(each.value, "domain_src_template", "")
  domain_type         = lookup(each.value, "domain_type", "instance")
  name                = "${each.value.name}${local.defaults.intersight.profiles.domain.name_suffix}"
  organization        = local.orgs[lookup(each.value, "organization", local.defaults.intersight.organization)]
  serial_numbers      = lookup(each.value, "serial_numbers", [])
  tags                = lookup(each.value, "tags", local.defaults.intersight.tags)
}
