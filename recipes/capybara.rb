if config['capybara'] and not recipe?('cucumber')
  gem 'capybara-webkit', :group => :test if config['capybara_webkit'] 

  gem 'capybara', :group => [:development, :test]

  after_bundler do
    create_file "spec/support/capybara.rb", <<-RUBY
require 'capybara/rails'
require 'capybara/rspec'
    RUBY

    create_file "spec/requests/home_spec.rb", <<-RUBY
require 'spec_helper'

describe 'visiting the homepage' do
  before do
    visit '/'
  end

  it 'should have a body' do
    page.should have_css('body')    
  end
end
    RUBY
  end
end

__END__

name: Capybara
description: "Use the Capybara acceptance testing libraries with RSpec."
author: iku-jt

requires: [rspec]
run_after: [rspec] 
exclusive: acceptance_testing 
category: testing
tags: [acceptance]

config:
  - capybara:
      type: boolean
      prompt: Would you like to use Capybara?
  - capybara_webkit:
      type: boolean
      prompt: Would you like to use Webkit with Capybara?
