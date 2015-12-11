include_recipe "nginx::source"

%w(pem key).each do |ext|
    cookbook_file "cert.#{ext}" do
        path "/etc/ssl/admin_panel.cert.#{ext}"
        action :create
        notifies :reload, resources(:service => "nginx"), :immediately
    end
end

directory "#{node.admin_app_nginx.logs_dir}" do
    owner "vagrant"
    group "vagrant"
    mode "0755"
    recursive true
end

template "#{node.nginx.dir}/sites-available/admin_panel.conf" do
    source "admin.nginx.conf.erb"
    mode "0644"
    notifies :reload, resources(:service => "nginx"), :immediately
end

nginx_site "admin_panel.conf"
