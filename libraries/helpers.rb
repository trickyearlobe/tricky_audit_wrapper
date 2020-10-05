# Monkey patch Chef::Node to add a cookbook_name method for attribute namespacing
# Helpful to avoid lots of code changes if the cookbook is forked.
unless ::Chef::Node.method_defined?(:cookbook_name)
  ::Chef::Node.define_method(:cookbook_name) do
    self.source_file.split(File::SEPARATOR)[-3]
  end
end
