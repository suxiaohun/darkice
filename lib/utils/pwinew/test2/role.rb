require 'java'
require './callme.jar'

java_import "com.example.CallMe"
java_import "protocol.GameDB"
java_import "com.goldhuman.IO.Protocol.Protocol"
java_import "protocol.ClientManager"


c = CallMe.new
c.hello


Protocol.Client(ClientManager.GetInstance())

id = 1040
#gamedb = GameDB.new
#puts GameDB.methods
puts GameDB.getRolelist(id)



