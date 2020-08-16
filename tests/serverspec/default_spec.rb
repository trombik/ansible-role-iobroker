require "spec_helper"
require "serverspec"

npm_packages = %w[
  iobroker
]
service = "iobroker"
user    = "iobroker"
group   = "iobroker"
ports   = [
  8081, # Web UI
  9000,
  9001
]
groups = case os[:family]
         when "ubuntu"
           %w[audio dialout tty video]
         end
iobroker_root = case os[:family]
                when "ubuntu"
                  "/opt/iobroker"
                end

describe group(group) do
  it { should exist }
end

describe user(user) do
  it { should exist }
  it { should belong_to_primary_group group }
  groups.each do |g|
    it { should belong_to_group g }
  end
  it { should have_home_directory iobroker_root }
end

describe command "cd #{iobroker_root} && npm ls" do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq "" }
  npm_packages.each do |p|
    its(:stdout) { should match(/#{p}@\d+\.\d+\.\d+$/) }
  end
end

describe command "#{iobroker_root}/iob status" do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq "" }
  its(:stdout) { should match(/At least one iobroker host is running/) }
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
