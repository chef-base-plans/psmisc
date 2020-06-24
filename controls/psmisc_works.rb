title 'Tests to confirm psmisc works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'psmisc')

control 'core-plans-psmisc-works' do
  impact 1.0
  title 'Ensure psmisc works as expected'
  desc '
  Verify psmisc by ensuring that
  (1) its installation directory exists 
  (2) all executables beneath bin return the expected
  version: fuser, killall, peekfd, prtstat, pslog, and pstree.
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stderr') { should be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]

  # fuser
  fuser_full_path = File.join(plan_installation_directory.stdout.strip, "bin/fuser")
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  describe command("#{fuser_full_path} --version") do
    its('exit_status') { should eq 0 }
    its('stderr') { should_not be_empty }
    its('stderr') { should match /fuser \(PSmisc\) #{plan_pkg_version}/ }
    its('stdout') { should be_empty }
  end
  
  # killall
  killall_full_path = File.join(plan_installation_directory.stdout.strip, "bin/killall")
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  describe command("#{killall_full_path} --version") do
    its('exit_status') { should eq 0 }
    its('stderr') { should_not be_empty }
    its('stderr') { should match /killall \(PSmisc\) #{plan_pkg_version}/ }
    its('stdout') { should be_empty }
  end
  
  # peekfd
  peekfd_full_path = File.join(plan_installation_directory.stdout.strip, "bin/peekfd")
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  describe command("#{peekfd_full_path} --version") do
    its('exit_status') { should_not eq 0 }
    its('stderr') { should_not be_empty }
    its('stderr') { should match /peekfd \(PSmisc\) #{plan_pkg_version}/ }
    its('stdout') { should be_empty }
  end
  
  # prtstat
  prstat_full_path = File.join(plan_installation_directory.stdout.strip, "bin/prtstat")
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  describe command("#{prstat_full_path} --version") do
    its('exit_status') { should eq 0 }
    its('stderr') { should_not be_empty }
    its('stderr') { should match /prtstat \(PSmisc\) #{plan_pkg_version}/ }
    its('stdout') { should be_empty }
  end
  
  # pslog
  pslog_full_path = File.join(plan_installation_directory.stdout.strip, "bin/pslog")
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  describe command("#{pslog_full_path} --version") do
    its('exit_status') { should eq 0 }
    its('stderr') { should_not be_empty }
    its('stderr') { should match /pslog \(PSmisc\) #{plan_pkg_version}/ }
    its('stdout') { should be_empty }
  end

  # pstree
  pstree_full_path = File.join(plan_installation_directory.stdout.strip, "bin/pstree")
  describe command("#{pstree_full_path} --version") do
    its('exit_status') { should eq 0 }
    its('stderr') { should_not be_empty }
    its('stderr') { should match /pstree \(PSmisc\) #{plan_pkg_version}/ }
    its('stdout') { should be_empty }
  end

end