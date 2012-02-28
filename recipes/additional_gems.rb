# To not create lots of recipes added a number of simple-to-install gems

# Pagination
if config['kaminari']
  gem 'kaminari'
end

if config['cancan']
  gem 'cancan'
end

if config['inherited_resources']
  gem 'inherited_resources'
end

if config['has_scope']
  gem 'has_scope'
end

if config['responders']
  gem 'responders'
  after_bundler do
    generate 'responders:install'
  end
end

if config['show_for']
  gem 'show_for'
  after_bundler do
    generate 'show_for:install'
  end
end

if config['simple_form']
  gem 'simple_form'
  after_bundler do
    generate 'simple_form:install' + (recipe?('twitter_bootstrap') ? ' --bootstrap' : '')
  end
end

if config['unicorn']
  gem 'unicorn', group: :production
end

if config['rmagick']
  gem 'rmagick'
end

if config['fabrication']
  gem 'fabrication'
end

if config['cancan']
  gem 'cancan'
end

if config['responders']
  gem 'responders'
end

if config['postgres'] and not recipe?('mongoid')
  gem 'pg', '~> 0.13'
end

if config['pacecar']
  gem 'pacecar'
end

if config['state_machine']
  gem 'state_machine'
end

if config['fog']
  gem 'fog'
end

if config['yajl_ruby']
  gem 'yajl-ruby'
end

if config['newrelic_rpm']
  gem 'newrelic_rpm'
end

if config['tddium']
  gem 'tddium'
end

if config['factory_girl_rails']
  gem 'factory_girl_rails'
end

__END__

name: Additional Gems
description: Additional gems with simple installation
author: iku-jt

config:
  - kaminari:
      type: boolean
      prompt: Would you like to use kaminari for pagination?
  - cancan:
      type: boolean
      prompt: Would you like to install CanCan as authorization library?
  - inherited_resources:
      type: boolean
      prompt: Would you like to speed up your development with Inherited Resources?
  - has_scope:
      type: boolean
      prompt: Would you like to install HasScope?
  - responders:
      type: boolean
      prompt: Would you like to DRY our code with Responders?
  - show_for:
      type: boolean
      prompt: Would you like to quickly show model info with ShowFor?
  - simple_form:
      type: boolean
      prompt: Would you like to install SimpleForm?
  - unicorn:
      type: boolean
      prompt: Would you like to use Unicorn?
  - rmagick:
      type: boolean
      prompt: Would you like to install RMagick?
  - fabrication:
      type: boolean
      prompt: Would you like to install Fabrication?
  - cancan:
      type: boolean
      prompt: Would you like to install CanCan?      
  - responders:
      type: boolean
      prompt: Would you like to install Responders?
  - postgres:
      type: boolean
      prompt: Would you like to use PostgreSQL?
  - pacecar:
      type: boolean
      prompt: Would you like to generate scope methods with Pacecar?
  - state_machine:
      type: boolean
      prompt: Would you like to add AASM?
  - fog:
      type: boolean
      prompt: Would you like to use Fog?
  - yajl_ruby:
      type: boolean
      prompt: Would you like to use YAJL C Bindings for Ruby?
  - newrelic_rpm:
      type: boolean
      prompt: Would you like to use New Relic Ruby Agent?
  - tddium:
      type: boolean
      prompt: Would you like to use tddium?
  - factory_girl_rails:
      type: boolean
      prompt: Would you like to use factory_girl_rails?
