require 'rake'
require 'rspec/core/rake_task'
require 'aws-sdk-v1'

task :spec    => 'spec:all'
task :default => :spec

namespace :spec do
  ec2 = AWS::EC2.new
  instances = ec2.instances.with_tag("role","builder")
  targets = instances.collect { |i| i.public_ip_address }

  task :all     => targets
  task :default => :all

  targets.each do |target|
    original_target = target == "_default" ? target[1..-1] : target
    desc "Run serverspec tests to #{original_target}"
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      ENV['TARGET_HOST'] = original_target
      t.pattern = "spec/*_spec.rb"
    end
  end
end
