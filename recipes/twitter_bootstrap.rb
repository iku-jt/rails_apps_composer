# Created instead of html5 recipe to be yes/no question.

if config['bootstrap']
  # https://github.com/thomas-mcdonald/bootstrap-sass
  # http://rubysource.com/twitter-bootstrap-less-and-sass-understanding-your-options-for-rails-3-1/
  gem 'bootstrap-sass', '~> 2.0.1'
end

after_bundler do
  say_wizard "HTML5 recipe running 'after bundler'"
  # add a humans.txt file
  get "https://raw.github.com/RailsApps/rails3-application-templates/master/files/humans.txt", "public/humans.txt"
  # install a front-end framework for HTML5 and CSS3
  if config['bootstrap']
    say_wizard "installing Twitter Bootstrap HTML5 framework"
    insert_into_file "app/assets/javascripts/application.js", "//= require bootstrap\n", :after => "jquery_ujs\n"
    copy_file 'app/assets/stylesheets/application.css', 'app/assets/stylesheets/application.css.scss'
    remove_file 'app/assets/stylesheets/application.css'
    insert_into_file "app/assets/stylesheets/application.css.scss", "\n@import 'bootstrap';\n", :after => "*/\n"
  end
  # Set up the default application layout
  if recipes.include? 'haml'
    # Haml version of default application layout
    remove_file 'app/views/layouts/application.html.erb'
    remove_file 'app/views/layouts/application.html.haml'
    get "https://raw.github.com/RailsApps/rails3-application-templates/master/files/views/layouts/application.html.haml", "app/views/layouts/application.html.haml"
    gsub_file "app/views/layouts/application.html.haml", /App_Name/, "#{app_name.humanize.titleize}"
  else
    # ERB version of default application layout
    remove_file 'app/views/layouts/application.html.erb'
    remove_file 'app/views/layouts/application.html.haml'
    get "https://raw.github.com/RailsApps/rails3-application-templates/master/files/views/layouts/application.html.erb", "app/views/layouts/application.html.erb"
    gsub_file "app/views/layouts/application.html.erb", /App_Name/, "#{app_name.humanize.titleize}"
  end
end

__END__

name: twitter-bootstrap
description: "Install Twitter-Bootstrap"
author: iku-jt

category: other
tags: [utilities, configuration]

config:
  - bootstrap:
      type: boolean
      prompt: Do you eant to use Twitter-Bootstrap?
