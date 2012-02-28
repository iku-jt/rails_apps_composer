if connect['simplecov']
  gem 'simplecov', :require => false, :group => :test
  simplecov <<-TEXT
  require 'simplecov'
  SimpleCov.start 'rails'
  TEXT
  if recipe?('rspec')
    prepend_file "spec/spec_helper.rb", simplecov
  elsif recipe?('cucumber')
    prepend_file "features/support/env.rb", simplecov
  else # Test:Unit assumed
    prepend_file "test/test_helper.rb", simplecov
  end
else
  recipes.delete('simplecov')
end


__END__

name: SimpleCov
description: Code coverage for Ruby 1.9
author: iku-jt

after: [rspec, cucumber]

config:
  - simplecov:
      type: boolean
      prompt: Would you like to use SimpleCov?
