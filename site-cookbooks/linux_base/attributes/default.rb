node.default['nodejs']['engine'] = 'node'
node.default['nodejs']['install_method'] = 'source'
node.default['nodejs']['source']['checksum'] = 'a779e024f800b5ec51f375fa1c14eda7254216daa36a1960cc1e4195b9fc22c3'
node.default['nodejs']['version'] = '5.1.1'

node.default['pm2_apps'] = {
	'api' => {
        'root_dir' => '/codebase',
        'logs_dir' => '/var/log/api-app',
        'ignore_watch' => ["node_modules", ".git", "data"],
        'debug_port' => 5858
    }
};