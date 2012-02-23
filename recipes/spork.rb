if config['spork']
  gem 'spork', :group => :test

  after_bundler do
    if recipes?('rspec')
      run 'spork rspec --bootstrap'
    elsif recipes?('cucumber')
      run 'spork cucumber --bootstrap'
    else
      # Test:Unit assumed
      gem 'spork-testunit'
      run 'spork test_unit --bootstrap'
    end
  end
else
  recipes.delete('spork')
  say_wizard "Spork recipe skipped."
end

__END__

name: spork
description: "Test server"
author: iku-jt

run_after: [rspec, cucumber]
category: other
tags: [dev]

config:
  - spork:
      type: boolean
      prompt: Would you like to use Spork?
