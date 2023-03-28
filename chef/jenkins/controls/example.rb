params = yaml(content: inspec.profile.file('params.yaml')).params

required_modules = params['modules']

control 'required-modules' do
  impact 1.0
  title 'Required modules'
  desc 'The required modules should be installed.'
  describe jenkins do
    required_modules.each do |required_module|
      its('modules') { should include required_module }
    end
  end
end
