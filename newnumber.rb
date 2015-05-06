#!/usr/bin/ruby
# encoding: UTF-8

require 'yaml'
require 'i18n'
require 'i18n/backend/fallbacks'
require 'rack-user-locale'
require "tilt/haml"
require "tilt/sass"
require 'sinatra/base'

class MyApp < Sinatra::Base
  configure do
    enable :sessions

    use Rack::Static, :urls => ["/css", "/js"], :root => "public"
    use Rack::UserLocale, :accepted_locales => [:en, :de] #TODO: make this dynamic

    I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
    I18n.load_path = Dir[File.join(settings.root, 'i18n', '*.yml')]
    I18n.backend.load_translations
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
