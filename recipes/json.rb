if config['jbuilder']
  gem 'jbuilder'
else
  recipes.delete('jbuilder')
end

__END__

name: JBuilder
description: "JBuilder is a simple templating engine for generating JSON output"
author: iku-jt

tags: [json, templating]

config:
  - jbuilder:
      type: boolean
      prompt: Would you like to use JBuilder to generate JSON output?
