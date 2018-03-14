desc 'All tests'
task :tst do
  sh('brakeman -q')
  sh('reek')
  sh('rspec')
end
