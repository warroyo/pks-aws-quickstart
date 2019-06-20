network = "{{ (ds "data").network_name }}"
dns_zone_name = "{{ (ds "data").dns_zone_id }}"
public_subnet_ids = [ {{ range (ds "data").public_subnet_ids }}
"{{.}}",
{{end}}
]
security_groups = ["{{ (ds "data").pks_master_security_group_id }}"]