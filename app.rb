require 'rubygems'
require 'bundler'

Bundler.require

set :database, {adapter: "sqlite3", database: "users.sqlite3"}

class User < ActiveRecord::Base
  validates_presence_of :name
end

get '/' do
  erb :index
end

get '/register' do
  erb :register
end

get '/user/:name' do
  @user = User.find_by(name: params[:name])
  erb :user
end

post '/create' do
  @user = User.new(name: params[:name])
  if @user.save
    puts "ユーザーの登録に成功"
    puts @user
    puts @user.name
    redirect '/'
  else
    erb :register
  end
end

# get '/now' do
#   @time = Time.now.strftime("現在時刻 %H時 %M分 %S秒")
#   @time = time.strftime("現在時刻 %H時 %M分 %S秒")
#   erb :time
# end