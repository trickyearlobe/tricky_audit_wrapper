# Make sure that all the common attributes are already loaded
include_attribute "#{cookbook_name}::default"

# RHEL nodes have CIS profiles which can be level 1 or 2, and can be server or workstation
default[cookbook_name]['profiles']['platform']['redhat']['5'] = 'cis-rhel5-level1'
default[cookbook_name]['profiles']['platform']['redhat']['6'] = 'cis-rhel6-level1-server'
default[cookbook_name]['profiles']['platform']['redhat']['7'] = 'cis-rhel7-level1-server'
default[cookbook_name]['profiles']['platform']['redhat']['8'] = 'cis-rhel8-level1-server'

# CentOS nodes have CIS profiles which can be level 1 or 2, and can be server or workstation
default[cookbook_name]['profiles']['platform']['centos']['6'] = 'cis-centos6-level1-server'
default[cookbook_name]['profiles']['platform']['centos']['7'] = 'cis-centos7-level1-server'
default[cookbook_name]['profiles']['platform']['centos']['8'] = 'cis-centos8-level1-server'

# Ubuntu nodes have CIS profiles which can be level 1 or 2, and can be server or workstation
default[cookbook_name]['profiles']['platform']['ubuntu']['12'] = 'cis-ubuntu12.04lts-level1'
default[cookbook_name]['profiles']['platform']['ubuntu']['14'] = 'cis-ubuntu14.04lts-level1'
default[cookbook_name]['profiles']['platform']['ubuntu']['16'] = 'cis-ubuntu16.04lts-level1-server'
default[cookbook_name]['profiles']['platform']['ubuntu']['18'] = 'cis-ubuntu18.04lts-level1-server'

# Windows nodes have CIS profiles which can be level 1 or 2, and may be with or without bitlocker
# In addition, Windows server has "member server" and "domain controller" variants
default[cookbook_name]['profiles']['platform']['windows']['10.0 Workstation'] = 'cis-windows10-1511-level1'
default[cookbook_name]['profiles']['platform']['windows']['6.3 Workstation'] = 'cis-windows8.1-level1'
default[cookbook_name]['profiles']['platform']['windows']['6.2 Workstation'] = 'cis-windows8-level1'
default[cookbook_name]['profiles']['platform']['windows']['6.1 Workstation'] = 'cis-windows7-level1'
# Windows server version numbers are a mess from 2016 onwards - see https://en.wikipedia.org/wiki/List_of_Microsoft_Windows_versions
# default[cookbook_name]['profiles']['platform']['windows']['10.0 Server'] = 'tba'
default[cookbook_name]['profiles']['platform']['windows']['6.3 Server'] = 'cis-windows2012r2-level1-memberserver'
default[cookbook_name]['profiles']['platform']['windows']['6.2 Server'] = 'cis-windows2012-level1-memberserver'



# Some intermediate variables to make the code look a bit prettier
namespace = node[cookbook_name]['automate-namespace']
platform = node['platform']

case platform
when "centos","redhat","ubuntu"
  platform_release = node['platform_version'].split('.').first
when "windows"
  platform_release = "#{node['platform_version'].split('.')[0..1].join('.')} #{node['kernel']['product_type']}"
else
  platform_release = node['platform_version']
end

# Find the profile for the platform/release and add it to default['audit']['profiles']
if node[cookbook_name]['profiles']['platform'][platform] && node[cookbook_name]['profiles']['platform'][platform][platform_release]
  profile_name = node[cookbook_name]['profiles']['platform'][node['platform']][platform_release]
  default['audit']['profiles'][profile_name] = { compliance: "#{namespace}/#{profile_name}"}
else
  Chef::Log.warn "Cookbook #{cookbook_name} doesn't have a default profile for #{platform} release #{platform_release}"
end

