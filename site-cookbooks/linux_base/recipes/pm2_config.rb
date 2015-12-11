appsArr = []

if node.attribute?(:pm2_apps) && !node[:pm2_apps].empty? then
    node[:pm2_apps].each do |app_name, app|
        buf = {
            :name => app_name,
            :script => "bin/www",
            :cwd => app[:root_dir],
            :error_file => "#{app[:logs_dir]}/app.pm2.stderr.log",
            :out_file => "#{app[:logs_dir]}/app.pm2.stdout.log",
            :pid_file => "#{app[:logs_dir]}/app.pm2.pid",
            :env => {
                "NODE_ENV" => (node.chef_environment != "" ? node.chef_environment : "production")
            },
            :max_restarts => 10,
            :min_uptime => 240
        }

        directory "#{app[:logs_dir]}" do
            owner "vagrant"
            group "vagrant"
            mode "0755"
            recursive true
        end

        if node.chef_environment === "development" then
            buf[:watch] = true
            buf[:ignore_watch] = app[:ignore_watch]
            buf[:watch_options] = {:usePolling => true}

            node_args = "--no-lazy"
            if (app.has_key?('debug_port')) then
                node_args += " --debug=#{app[:debug_port]}"
            end
            buf[:node_args] = node_args
        else
            buf[:exec_mode] = "cluster"
            buf[:instances] = 3
        end

        appsArr.push(buf)
    end
end

if appsArr.length > 0 then
    pm2Conf = {:apps => appsArr}

    file "/apps.json" do
        content JSON.pretty_generate(pm2Conf)
        mode "0644"
    end
else
    file "/apps.json" do
      action :delete
    end
end
