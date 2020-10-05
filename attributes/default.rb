# Make sure that all the audit cookbook attributes are already loaded
include_attribute 'audit::default'

# Where we send reports and get profiles from
default['audit']['fetcher']  = 'chef-server'
default['audit']['reporter'] = ['chef-server-automate', 'json-file']
default['audit']['json_file']['location'] = File.join(Chef::Config['file_cache_path'],'compliance-report.json')
# default['audit']['reporter'] = 'chef-automate'
# default['audit']['fetcher']  = 'chef-automate'

# The user in Chef Automate that owns the profiles we will scan with
default[cookbook_name]['automate-namespace'] = 'admin'

# This waivers file will be written by the default recipe and is used by the Inspec scan(s).
default['audit']['waiver_file'] = File.join(Chef::Config['file_cache_path'],'waivers.yaml')
