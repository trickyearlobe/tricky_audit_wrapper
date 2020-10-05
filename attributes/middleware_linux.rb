# Bail out if we're not running Linux
return unless node['platform'] == 'windows'

# Make sure that all the common attributes are already loaded
include_attribute "#{cookbook_name}::default"

