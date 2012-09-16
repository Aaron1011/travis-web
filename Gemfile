source :rubygems

gem 'travis-api',     github: 'travis-ci/travis-api', branch: 'sf-use-services'
gem 'travis-core',    github: 'travis-ci/travis-core', branch: 'sf-more-services'
gem 'travis-support', github: 'travis-ci/travis-support'

gem 'unicorn'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'yard-sinatra',   github: 'rkh/yard-sinatra'

gem 'pg',             '~> 0.13.2'
gem 'newrelic_rpm',   '~> 3.3.0'
gem 'hubble',         git: 'git://github.com/roidrage/hubble'

group :assets do
  gem 'rake-pipeline', github: 'livingsocial/rake-pipeline'
  gem 'rake-pipeline-web-filters', github: 'wycats/rake-pipeline-web-filters'

  gem 'coffee-script'
  gem 'compass'
  gem 'tilt'
  gem 'guard'
end

group :development do
  gem 'foreman'
  gem 'rb-fsevent', '~> 0.9.1'
end
