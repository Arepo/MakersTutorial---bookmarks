require 'sinatra'
require 'data_mapper'
require 'sinatra/flash'
require './lib/link'
require './lib/tag'
require './lib/user'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'
require_relative 'controllers/links'
require_relative 'controllers/sessions'
require_relative 'controllers/tags'
require_relative 'controllers/users'

enable :sessions
set :session_secret, 'super secret'






