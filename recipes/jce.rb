case node["java"]["jdk_version"]
when "6", 6, "7", 7
	jce_url = node["java_ext"]["jce"][node["java"]["jdk_version"].to_s]["url"]
	jce_checksum = node["java_ext"]["jce"][node["java"]["jdk_version"].to_s]["checksum"]
else
	Chef::Aplication.fatal! "Unknown java version #{node["java"]["jdk_version"]}"
end

unless node['java']['oracle']['accept_oracle_download_terms']
	Chef::Application.fatal!("You must set the attribute node['java']['oracle']['accept_oracle_download_terms'] to true if you want to download directly from the oracle site!")
end

package "unzip"
package "curl"

directory node["java_ext"]["jce_home"] do
	recursive true
	mode "0755"
end

directory ::File.join(node["java"]["java_home"], "lib", "security") do
	mode "0755"
end

bash "download and extract jce" do
	code <<-EOS
	if ! echo "#{jce_checksum}  jce.zip" | sha256sum -c - >/dev/null; then
		curl -L --cookie 'oraclelicense=accept-securebackup-cookie;gpw_e24=http://edelivery.oracle.com' -o jce.zip #{jce_url}
	fi
	unzip -o jce.zip
	EOS
	creates ::File.join(node["java_ext"]["jce_home"], "README.txt")
	cwd node["java_ext"]["jce_home"]
end

%w(local_policy.jar US_export_policy.jar).each do |jar|
	jar_path = ::File.join(node["java"]["java_home"], "lib", "security", jar)
	file ::File.join() do
		action :delete
		only_if {::File.symlink? jar_path}
	end
	link jar_path do
		to ::File.join(node["java_ext"]["jce_home"], "jce", jar)
	end
end