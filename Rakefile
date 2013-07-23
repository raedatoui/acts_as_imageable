require 'rake/testtask'

desc 'Test the acts_as_imageable plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

task default: :test
