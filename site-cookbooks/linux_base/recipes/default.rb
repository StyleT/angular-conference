include_recipe "nodejs"

nodejs_npm 'pm2'
nodejs_npm 'express-generator'
include_recipe "#{cookbook_name}::pm2_config"
