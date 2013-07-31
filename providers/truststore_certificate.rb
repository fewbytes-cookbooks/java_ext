use_inline_resources

def whyrun_supported?
	true
end

action :add do
	bin_path = new_resource.java_bin_path || ::File.join(node["java"]["java_home"], "bin")
	
	execute "import #{new_resource.cert_alias} certificate" do
		command "echo '#{new_resource.certificate}' | #{bin_path}/keytool -importcert -keystore #{new_resource.truststore_path}" +
			" -alias '#{new_resource.cert_alias}'" +
			" -keypass #{new_resource.password} -storepass #{new_resource.password} -noprompt"
		user new_resource.owner
		group new_resource.group
		not_if "#{bin_path}/keytool -list -keystore #{new_resource.truststore_path} " +
			" -keypass #{new_resource.password} -storepass #{new_resource.password}" +
			" -alias #{new_resource.cert_alias}"
	end

	file new_resource.truststore_path do
		owner new_resource.owner
		group new_resource.group
		mode new_resource.mode
	end
end