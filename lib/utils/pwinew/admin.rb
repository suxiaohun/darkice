require 'sinatra'
require 'active_record'
require 'pry'
require 'digest'
require 'base64'

ActiveRecord::Base.establish_connection(
  :adapter => "mysql2",
  :host => "10.4.243.51",
  :port => 31996,
  :username => "root",
  :password => "123456",
  :database => "pw"
)

class User < ActiveRecord::Base
end

class Auth < ActiveRecord::Base
  self.table_name = "auth"
end

set :bind, '0.0.0.0'

set :public_folder, 'public'

messages = {
  "register_ok" => "<font color=\"00cc00\">Account Created</font>",
  "cubi_ok" => "<font color=\"00cc00\">Cubi Added</font>",
  "grant_ok" => "<font color=\"00cc00\">GM Access Granted</font>"
}

get '/' do
  erb :index
end
get '/index' do
  erb :index
end

get '/accounts' do
  # binding.pry
  @gms = Auth.all.map(&:userid).uniq
  @users = User.all
  @message = messages[params[:message]] if params[:message]
  erb :accounts
end

post '/register' do
  login = params[:login]
  passwd = params[:passwd]
  mail = params[:mail] || ''

  password = passwd_encrypt(login + passwd)

  # binding.pry
  query = "call adduser('" + login + "', '" + password + "', '0', '0', '0', '0', '" + mail + "', '0', '0', '0', '0', '0', '0', '0', '', '', '" + password + "')"

  ActiveRecord::Base.connection.execute(query)
  redirect to('/accounts?message=register_ok')
end

post '/grant' do
  type = params[:type]
  action = params[:act]
  query = ""
  if type == "name"
    query = "SELECT ID FROM users WHERE name='#{params[:ident]}'"
  elsif type == "id"
    query = "SELECT ID FROM users WHERE id=#{params[:ident]}"
  end
  res = ActiveRecord::Base.connection.execute(query)
  if res.size > 0
    id = res.first[0]
    q = ''
    if action == "add"
      q1 = "call addGM('#{id}', '1')"
      ActiveRecord::Base.connection.execute(q1)
      add_cubi(id, 999999)
    elsif action == "delete"
      q = "DELETE FROM auth WHERE userid='#{id}'"
      ActiveRecord::Base.connection.execute(q)
    end
  end
  redirect to('/accounts?message=grant_ok')
end

post '/cubi' do
  type = params[:type]
  query = ""
  if type == "name"
    query = "SELECT ID FROM users WHERE name='#{params[:ident]}'"
  elsif type == "id"
    query = "SELECT ID FROM users WHERE id=#{params[:ident]}"
  end
  res = ActiveRecord::Base.connection.execute(query)
  if res.size > 0
    id = res.first[0]
    add_cubi(id, params[:amount])
  end
  redirect to('/accounts?message=cubi_ok')
end

post '/roles' do
  id = 1040
  binding.pry
  gamedb = GameDB.new
  gamedb.getRolelist(id)

end





private

def add_cubi(userid, amount = 9)
  query = "call usecash ( '#{userid}' , 1, 0, 1, 0, '#{100 * amount.to_i}', 1, @error)"
  ActiveRecord::Base.connection.execute(query)
end

def passwd_encrypt(str)
  md5_str = Digest::MD5.digest str
  Base64.encode64 md5_str
end

# require 'java'
# require './test/callme.jar'
#
# java_import "com.example.CallMe"
#
#
#
# c = CallMe.new
# c.hello