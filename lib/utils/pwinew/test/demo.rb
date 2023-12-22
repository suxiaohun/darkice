require 'java'
require './callme.jar'

java_import "example.JavaMan"
java_import "com.example.CallMe"

t = JavaMan.new
t.hello


c = CallMe.new
c.hello

