APP_ENV = ENV['APP_ENV'] || ENV['RACK_ENV'] || 'development'

require 'bundler/setup'
Bundler.require(:default, APP_ENV)

require 'active_record'
require 'active_support'

Dir.glob('./lib/*.rb').each do |file|
  require file
end


Dir.glob('./lib/db/*').each do |folder|
  Dir.glob(folder + "/*.rb").each do |file|
    require file
  end
end

Dir['./workers/*.rb'].each { |f| require f }

Dir.glob('./initializers/*.rb').each do |file|
  require file
end
