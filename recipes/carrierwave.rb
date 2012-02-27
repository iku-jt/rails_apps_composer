if config['carrierwave']
  gem 'carrierwave'

  if recipe?('mongoid')
    gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
  end
else
  recipes.delete('carrierwave')
end



__END__

name: Carrierwave
description: Uploading files from Ruby applications
author: iku-jt

run_after: [mongoid]

config:
  - carrierwave:
      type: boolean
      prompt: Would you like to use CarrierWave?
