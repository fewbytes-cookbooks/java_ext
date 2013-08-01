actions :generate

default_action :generate

attribute :dn, :kind_of => String, :required => true
attribute :keystore_path, :kind_of => String, :name_attribute => true
attribute :mode, :kind_of => [String, Numeric], :default => "0600"
attribute :owner, :kind_of => [String, Numeric], :default => 'root'
attribute :group, :kind_of => [String, Numeric], :default => 'root'
attribute :cert_alias, :kind_of => String, :required => true
attribute :password, :kind_of => String, :required => true
attribute :java_bin_path, :kind_of => String, :default => nil
attribute :x509_extensions, :kind_of => Hash, :default => nil

def with_certificate(&block)
	if block_given? and block
		@with_certificate = block
	else
		@with_certificate
	end
end
