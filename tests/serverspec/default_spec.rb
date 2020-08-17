require "spec_helper"
require "serverspec"

npm_packages = %w[
  iobroker
]
service = "iobroker"
user    = case os[:family]
          when "openbsd"
            "_iobroker"
          else
            "iobroker"
          end
group   = user
ports   = [
  8081, # Web UI
  9000,
  9001
]
# I am not yet sure which group is necessary and why.
groups = case os[:family]
         when "ubuntu", "redhat"
           %w[audio dialout tty video]
         when "freebsd", "openbsd"
           %w[dialer]
         end
iobroker_root = case os[:family]
                when "ubuntu", "redhat"
                  "/opt/iobroker"
                when "freebsd", "openbsd"
                  "/usr/local/iobroker"
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
