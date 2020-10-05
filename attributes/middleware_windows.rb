# Bail out if we're not running Windows (to avoid Win32 calls killing the Chef run on *nix)
return unless node['platform'] == 'windows'

# Make sure that all the common attributes are already loaded
include_attribute "#{cookbook_name}::default"

# Some intermediate variables to make the code look prettier
namespace = node[cookbook_name]['automate-namespace']

# Autodetect IIS
if ::Win32::Service.exists?('w3svc')
  default['audit']['profiles']['iis'] = { compliance: "#{namespace}/iis" }
end
