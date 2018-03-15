# frozen_string_literal: true

desc 'All tests'
task :tst do
  sh('brakeman -q')
  sh('reek')
  sh('rubocop')
  sh('rspec')
end
