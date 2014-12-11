require 'spec_helper'

describe 'java_ext::jce' do
  context file('/opt/java_ext/jce/6/local_policy.jar') do
    it { should be_file }
  end
  context file('/opt/java_ext/jce/6/US_export_policy.jar') do
    it { should be_file }
  end

  context file('/usr/lib/jvm/java/jre/lib/security/local_policy.jar') do
    it { should be_symlink }
    it { should be_linked_to '/opt/java_ext/jce/6/local_policy.jar' }
  end
  context file('/usr/lib/jvm/java/jre/lib/security/US_export_policy.jar') do
    it { should be_symlink }
    it { should be_linked_to '/opt/java_ext/jce/6/US_export_policy.jar' }
  end
end
