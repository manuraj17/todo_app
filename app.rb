# frozen_string_literal: true

require 'sinatra'
require 'sinatra/json'
require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.push_dir('app/controllers')
loader.push_dir('app/models')
loader.push_dir('app/services')
loader.setup

List.new

class App < Sinatra::Application
  use ListsController
  use MoveTodosController
  use CopyTodosController
  use TodosController
end
