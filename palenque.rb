require 'sinatra'
require 'sinatra/jsonp'
require 'thin'
require 'pi_piper'

# ============================= #
# Palenque Libs                 #
# ============================= #

Dir[File.join(".", "**/*.rb")].each do |file|
  require file
end

# ============================= #
# Config                        #
# ============================= #

set :bind, '0.0.0.0'
key = 'RASPBERRY4EVERY1';
