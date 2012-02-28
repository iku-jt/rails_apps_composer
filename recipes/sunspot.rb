if config['sunspot']
  gem 'sunspot_rails'

  if config['sunspot_solr']
    gem 'sunspot_solr', group: :development
    after_bundler do
      rake 'sunspot:solr:start'
    end
  end

  if config['sunspot_test']
    gem 'sunspot_test'
    after_bundler do
      if recipe?('cucumber')
        prepend_file "features/support/env.rb", "require 'sunspot_test/cucumber'"
      elsif recipe?('rspec')
        prepend_file "spec/spec_helper.rb", "require 'sunspot_test/rspec'"
      else # Test:Unit assumed
        prepend_file "test/test_helper.rb", "require 'sunspot_test/test_unit'"
      end
    end
  end

  after_bundler do
    generate 'sunspot_rails:install'
  end
else
  recipes.delete('sunspot')
end

__END__

name: Sunspot
description: Ruby library for interaction with the Solr search engine
author: iku-jt

config:
  - sunspot:
      type: boolean
      prompt: Would you like to use Sunspot?
  - sunspot_solr:
      type: boolean
      prompt: Would you like to use Sunspot Solr?
      if: sunspot
  - sunspot_test:
      type: boolean
      prompt: Would you like to use Sunspot Test?
      if: sunspot
