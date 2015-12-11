node.default['admin_app_nginx'] = {
    "host" => "admin.namp.local",
    "web_dir" => "/codebase/namp-admin/public",
    "logs_dir" => "/var/log/namp/namp-admin"
}

node.default['nginx']['version'] = '1.8.0'
node.default['nginx']['default_site_enabled'] = true
