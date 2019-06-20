network = "{{ (ds "data").network_name }}"
dns_zone_name = "{{ (ds "data").dns_zone_id }}"
public_subnet_ids = [ {{ range (ds "data").public_subnet_ids }}
"{{.}}",
{{end}}
]