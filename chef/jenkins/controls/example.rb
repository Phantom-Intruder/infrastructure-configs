control 'required-modules' do
  impact 1.0
  title 'Required modules'
  desc 'The required modules should be installed.'
  describe jenkins do
    its('modules') { should include jenkins }
    its('modules') { should include maven }
    its('modules') { should include alien }
    its('modules') { should include libaio1 }
  end
end
