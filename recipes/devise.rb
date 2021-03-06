# Application template recipe for the rails_apps_composer. Check for a newer version here:
# https://github.com/RailsApps/rails_apps_composer/blob/master/recipes/devise.rb
# Based on original devise recipe, but multiple_choise changed to set of yes/no
# questions to keep compatibility with default-features.

if config['devise']
  gem 'devise', '>= 2.0.4'

  recipes << 'devise_confirmable' if config['devise_confirmable']
    
  if config['devise_invitable']
    gem 'devise_invitable', '>= 1.0.0'
    recipes << 'devise_confirmable'
    recipes << 'devise_invitable'
  end

else
  recipes.delete('devise')
  say_wizard "Devise recipe skipped."
end

if recipes.include? 'devise'
  after_bundler do

    say_wizard "Devise recipe running 'after bundler'"

    # Run the Devise generator
    generate 'devise:install'
    generate 'devise_invitable:install' if config['devise_invitable']
    # generate 'devise_invitable:install' if recipes.include? 'devise-invitable'

    if recipes.include? 'mongo_mapper'
      gem 'mm-devise'
      gsub_file 'config/initializers/devise.rb', 'devise/orm/', 'devise/orm/mongo_mapper_active_model'
      generate 'mongo_mapper:devise User'
    elsif recipes.include? 'mongoid'
      # Nothing to do (Devise changes its initializer automatically when Mongoid is detected)
      # gsub_file 'config/initializers/devise.rb', 'devise/orm/active_record', 'devise/orm/mongoid'
    end

    # Prevent logging of password_confirmation
    gsub_file 'config/application.rb', /:password/, ':password, :password_confirmation'

    if recipes.include? 'cucumber'
      # Cucumber wants to test GET requests not DELETE requests for destroy_user_session_path
      # (see https://github.com/RailsApps/rails3-devise-rspec-cucumber/issues/3)
      gsub_file 'config/initializers/devise.rb', 'config.sign_out_via = :delete', 'config.sign_out_via = Rails.env.test? ? :get : :delete'
    end

  end

  after_everything do

    say_wizard "Devise recipe running 'after everything'"

    if recipes.include? 'rspec'
      say_wizard "Copying RSpec files from the rails3-devise-rspec-cucumber examples"
      begin
        # copy all the RSpec specs files from the rails3-devise-rspec-cucumber example app
        get 'https://raw.github.com/RailsApps/rails3-devise-rspec-cucumber/master/spec/factories.rb', 'spec/factories.rb'
        remove_file 'spec/controllers/home_controller_spec.rb'
        remove_file 'spec/controllers/users_controller_spec.rb'
        get 'https://raw.github.com/RailsApps/rails3-devise-rspec-cucumber/master/spec/controllers/home_controller_spec.rb', 'spec/controllers/home_controller_spec.rb'
        get 'https://raw.github.com/RailsApps/rails3-devise-rspec-cucumber/master/spec/controllers/users_controller_spec.rb', 'spec/controllers/users_controller_spec.rb'
        remove_file 'spec/models/user_spec.rb'
        get 'https://raw.github.com/RailsApps/rails3-devise-rspec-cucumber/master/spec/models/user_spec.rb', 'spec/models/user_spec.rb'
      rescue OpenURI::HTTPError
        say_wizard "Unable to obtain RSpec example files from the repo"
      end
      remove_file 'spec/views/home/index.html.erb_spec.rb'
      remove_file 'spec/views/home/index.html.haml_spec.rb'
      remove_file 'spec/views/users/show.html.erb_spec.rb'
      remove_file 'spec/views/users/show.html.haml_spec.rb'
      remove_file 'spec/helpers/home_helper_spec.rb'
      remove_file 'spec/helpers/users_helper_spec.rb'
    end

  end
end

__END__

name: Devise
description: Utilize Devise for authentication, automatically configured for your selected ORM.
author: RailsApps

category: authentication
exclusive: authentication

config:
  - devise:
      type: boolean
      prompt: Would you like to use Devise for authentication?
  - devise_invitable:
      type: boolean
      prompt: Would you like to use Devise Invitable for send invitations by email?
  - devise_confirmable:
      type: boolean
      prompt: Would you like to use Devise Confirmable?
