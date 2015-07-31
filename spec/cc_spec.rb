require 'spec_helper'

describe file('/root/.ssh/cc_ssh_user.pem') do 
  it { should exist }
  it { should be_mode 400}
end

describe file('/root/.ssh/config') do 
  it { should exist }
  it { should contain 'User APKAJZRGXUTBEXCZFG5Q'}
end

describe command('ssh-keygen -H -F git-codecommit.us-east-1.amazonaws.com') do
  its(:exit_status) { should eq 0 }
end

describe package('git') do
  it { should be_installed }
end

describe command('aws --version') do
  its(:stdout) { should contain('aws-cli/1.7./[4-9][0-9]/') }
end

describe file('/srv/git/repos/hello-world/hello.txt') do
  it { should exist }
  it { should contain 'Hello World!' }
end
