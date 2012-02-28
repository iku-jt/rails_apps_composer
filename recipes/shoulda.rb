if config['shoulda']
  if recipe?('rspec')
    gem 'shoulda-matchers', group: :test
  else
    gem 'shoulda', group: :test
  end
else
  recipes.delete('shoulda')
end

__END__

name: Shoulda
description: Makes tests easy on the fingers and the eyes
author: iku-jt

after: [rspec, cucumber]

config:
  - shoulda:
      type: boolean
      prompt: Would you like to use Shoulda?
