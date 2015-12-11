include_recipe "nodejs"

nodejs_npm 'pm2'
include_recipe "#{cookbook_name}::pm2_config"
