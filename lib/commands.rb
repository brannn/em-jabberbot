require 'rubygems'
require 'eventmachine'

class Command
  include EM::Deferrable

   def foo
     10.times do |f|
       puts "Doing #{f}"
       sleep 0.05
     end
     set_deferred_status :succeeded
   end

   def haa
     10.times do |h|
       puts "Doing #{h}"
       sleep 0.05
     end
     set_deferred_status :succeeded
   end
end
