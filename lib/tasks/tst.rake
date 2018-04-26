# frozen_string_literal: true

desc 'All tests'
task :tst do
  sh('reek')
  sh('rubocop')
  sh('rspec')
  sh('brakeman -q')
end
