#!/usr/bin/ruby
# encoding: UTF-8

require 'yaml'
require "haml"
require "sass"
require 'sinatra/base'

class MyApp < Sinatra::Base
  configure do
    enable :sessions
  end
  configure :development, :test do
    set :oldNumber, '+491234567890'
    set :newNumber, '+490987654321'
  end
  configure :production do
    cfg = YAML.load_file("config.production.yaml")
    set :oldNumber, cfg["config"]["oldNumber"]
    set :newNumber, cfg["config"]["newNumber"]
  end

  get '/style.css' do
    sass :style
  end

  post '/' do
    redirect to("/#{params[:number]}")
  end

  get "/" do
    haml :index
  end

  get "/:number" do
    @newNumber = false
    @newNumber = settings.newNumber if settings.oldNumber == params[:number]

    haml :number
  end
end

MyApp.run! :host => '0.0.0.0', :port => 2342
