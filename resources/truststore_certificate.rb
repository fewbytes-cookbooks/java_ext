actions :add
default_action :add

attribute :certificate, :kind_of => String, :required => true
attribute :cert_alias, :name_attribute => true, :kind_of => String
attribute :truststore_path, :kind_of => String, :required => true
attribute :password, :kind_of => String, :required => true
attribute :mode, :kind_of => [String, Numeric], :default => "0600"
attribute :owner, :kind_of => [String, Numeric], :default => 'root'
attribute :group, :kind_of => [String, Numeric], :default => 'root'
attribute :java_bin_path, :kind_of => String, :default => nil

