require 'java'
require './lib/jio.jar'
require './lib/callme.jar'

java_import "com.example.CallMe"
java_import "protocol.GameDB"


c = CallMe.new
c.hello


id = 1040
gamedb = GameDB.new
gamedb.getRolelist(id)




