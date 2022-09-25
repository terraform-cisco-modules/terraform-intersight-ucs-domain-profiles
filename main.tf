locals {
  defaults   = lookup(var.model, "defaults", {})
  modules    = lookup(var.model, "modules", {})
  intersight = lookup(var.model, "intersight", {})
  orgs       = var.orgs
  profiles   = lookup(local.intersight, "profiles", {})
}

#____________________________________________________________
#
# Intersight UCS Domain Cluster Profile Resource
# GUI Location: Profiles > UCS Domain Profile > Create
#____________________________________________________________

module "domain" {
  source              = "terraform-cisco-modules/profiles-domain/intersight"
  version             = ">= 1.0.4"
  for_each            = { for dp in lookup(local.profiles, "domain", []) : dp.name => dp if lookup(local.modules, "profiles_domain", true) }
  action              = lookup(each.value, "action", local.defaults.intersight.profiles.domain.action)
  description         = lookup(each.value, "description", "")
  domain_src_template = lookup(each.value, "domain_src_template", "")
  domain_type         = lookup(each.value, "domain_type", "instance")
  name                = "${each.value.name}${local.defaults.intersight.profiles.domain.name_suffix}"
  organization        = local.orgs[lookup(each.value, "organization", local.defaults.intersight.organization)]
  serial_numbers      = lookup(each.value, "serial_numbers", [])
  tags                = lookup(each.value, "tags", local.defaults.intersight.tags)
}
