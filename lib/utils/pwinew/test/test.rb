require "java"

java_import "java.util.TreeSet"
java_import "com.example.CallMe"
java_import "com.xiaosu.Test"


puts "Hello from ruby"
set = TreeSet.new
set.add "foo"
set.add "Bar"
set.add "baz"
set.each { |v| puts "value: #{v}" }

cm = CallMe.new
cm.hello

t = Test.new
t.say

