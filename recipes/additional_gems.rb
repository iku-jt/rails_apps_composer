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
