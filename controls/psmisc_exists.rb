title 'Tests to confirm psmisc exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'psmisc')

control 'core-plans-psmisc-exists' do
  impact 1.0
  title 'Ensure psmisc exists'
  desc '
  Verify psmisc by ensuring all executables beneath bin exist: fuser,
  killall, peekfd, prtstat, pslog, and pstree.'
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stderr') { should be_empty }
  end

  # fuser
  fuser_full_path = File.join(plan_installation_directory.stdout.strip, "bin/fuser")
  describe file(fuser_full_path) do
    it { should exist }
  end

  # killall
  killall_full_path = File.join(plan_installation_directory.stdout.strip, "bin/killall")
  describe file(killall_full_path) do
    it { should exist }
  end

  # peekfd
  peekfd_full_path = File.join(plan_installation_directory.stdout.strip, "bin/peekfd")
  describe file(peekfd_full_path) do
    it { should exist }
  end

  # prtstat
  prtstat_full_path = File.join(plan_installation_directory.stdout.strip, "bin/prtstat")
  describe file(prtstat_full_path) do
    it { should exist }
  end

  # pslog
  pslog_full_path = File.join(plan_installation_directory.stdout.strip, "bin/pslog")
  describe file(pslog_full_path) do
    it { should exist }
  end

  # pstree
  pstree_full_path = File.join(plan_installation_directory.stdout.strip, "bin/pstree")
  describe file(pstree_full_path) do
    it { should exist }
  end

end
