#
# Cookbook:: tricky_audit_wrapper
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

include_recipe 'audit::default'

require 'yaml'
file File.join(Chef::Config['file_cache_path'],'waivers.yaml') do
  content node[cookbook_name]['waivers'].to_yaml
end

execute "knife ssl fetch -c #{Chef::Config['config_file']} #{Chef::Config['data_collector']['server_url']}"