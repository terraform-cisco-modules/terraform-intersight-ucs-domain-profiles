output "domain" {
  description = "Moid of the Domain Profiles."
  value = lookup(local.modules, "profiles_domain", true) ? {
    for v in sort(keys(module.domain)
  ) : v => module.domain[v] } : {}
}
