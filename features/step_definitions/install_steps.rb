require 'open3'
require_relative 'vars'

# Scenario: Download Keys and Repos sources and Update cache
When(/^I download Keys and Repos sources and Update cache$/) do
  cmd = "ansible-playbook -i inventory.ini playbook.main.yml --tags 'setup'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

Then(/^it should be successful$/) do
  expect(@status.success?).to eq(true)
end

# Scenario: Install Nodejs
When(/^I install Nodejs and Git$/) do
  cmd = "ansible-playbook -i inventory.ini playbook.main.yml --tags 'node_git'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

And(/^Nodejs should exist$/) do 
  cmd = "ssh -i '#{PATHTOPRIVATEKEY}' #{PUBDNS} 'node -v'"
  output, error, status = Open3.capture3 "#{cmd}"
  expect(status.success?).to eq(true)
  expect(output).to match("v")
end

And(/^Git should exist$/) do 
  cmd = "ssh -i '#{PATHTOPRIVATEKEY}' #{PUBDNS} 'git --version'"
  output, error, status = Open3.capture3 "#{cmd}"
  expect(status.success?).to eq(true)
  expect(output).to match("git version")
end

# Scenario: Install required Packages
When(/^I install required Packages$/) do
  cmd = "ansible-playbook -i inventory.ini playbook.main.yml --tags 'required_pkgs'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Install MongoDB
When(/^I install MongoDB$/) do
  cmd = "ansible-playbook -i inventory.ini playbook.main.yml --tags 'mongodb'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

And(/^MongoDB should be running$/) do
  cmd = "ssh -i '#{PATHTOPRIVATEKEY}' #{PUBDNS} 'sudo service mongod status'"
  output, error, status = Open3.capture3 "#{cmd}"
  expect(status.success?).to eq(true)
  expect(output).to match("mongod start/running")
end

# Scenario: Clone project repository
When(/^I clone project repository$/) do
  cmd = "ansible-playbook -i inventory.ini playbook.main.yml --tags 'git_clone'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Setup New Relic
When(/^I install newrelic and forever packages$/) do
  cmd = "ansible-playbook -i inventory.ini playbook.main.yml --tags 'newrelic_forever'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

And(/^the newrelic package should exist$/) do
  cmd = "ssh -i '#{PATHTOPRIVATEKEY}' #{PUBDNS} 'cd #{APPDIR} && ls node_modules | grep newrelic'"
  output, error, status = Open3.capture3 "#{cmd}"
  expect(status.success?).to eq(true)
  expect(output).to match("newrelic")
end

And(/^the forever package should exist$/) do
  cmd = "ssh -i '#{PATHTOPRIVATEKEY}' #{PUBDNS} 'cd #{APPDIR} && ls node_modules | grep forever'"
  output, error, status = Open3.capture3 "#{cmd}"
  expect(status.success?).to eq(true)
  expect(output).to match("forever")
end

When(/^I setup newrelic$/) do
  cmd = "ansible-playbook -i inventory.ini playbook.main.yml --tags 'newrelic_setup'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Install modules in package.json and start the app
When(/^I start the app$/) do
  cmd = "ansible-playbook -i inventory.ini playbook.main.yml --tags 'start_app'"
  output, error, @status = Open3.capture3 "#{cmd}"
end