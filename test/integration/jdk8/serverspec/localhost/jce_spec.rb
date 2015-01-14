require 'spec_helper'

def java_home
  File.expand_path("..", File.dirname(File.realpath(`which java`[0..-2])))
end

describe 'java_ext::jce' do
  context file('/opt/java_ext/jce/8/local_policy.jar') do
    it { should be_file }
  end
  context file('/opt/java_ext/jce/8/US_export_policy.jar') do
    it { should be_file }
  end

  context file("#{java_home}/jre/lib/security/local_policy.jar") do
    it { should be_symlink }
    it { should be_linked_to '/opt/java_ext/jce/8/local_policy.jar' }
  end
  context file("#{java_home}/jre/lib/security/US_export_policy.jar") do
    it { should be_symlink }
    it { should be_linked_to '/opt/java_ext/jce/8/US_export_policy.jar' }
  end
end

describe 'folder access mode' do
  Dir.glob('/opt/java_ext/**/*').each do |item|
      context file(item) do
        it { should be_readable }
        it { should be_executable } if File.directory? item
        it { should be_owned_by 'root'}
        it { should be_grouped_into 'root' }
      end
  end
end