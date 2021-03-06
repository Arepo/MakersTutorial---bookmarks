require 'sinatra'
require 'data_mapper'
require 'sinatra/flash'
# require 'sinatra/partial'
require './app/models/link'
require './app/models/tag'
require './app/models/user'

require_relative 'data_mapper_setup'
require_relative 'helpers/application'

require_relative 'controllers/application'
require_relative 'controllers/links'
require_relative 'controllers/sessions'
require_relative 'controllers/tags'
require_relative 'controllers/users'

enable :sessions
set :session_secret, 'super secret'
set :partial_template_engine, :erb





