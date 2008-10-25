#!/usr/bin/ruby

require 'rubygems'
require 'eventmachine'
require 'xmpp4r-simple'
require 'lib/commands'

CONF = YAML.load_file( 'bot.yml' )

COMMANDS = Array.new

CONF['commands'].each do |command|
  COMMANDS.push command
end

jabber = Jabber::Simple.new(CONF['xmpp']['jid'], CONF['xmpp']['pass'])

EM.run do
  EM::PeriodicTimer.new(0.05) do
    jabber.received_messages do |message|
      if COMMANDS.include?(message.body)
        EM.spawn do
          worker = Command.new
          worker.callback {jabber.deliver(message.from, "#{Time.now.to_s}: Job completed")}
          worker.send(message.body)
        end.notify
        jabber.deliver(message.from, "#{Time.now.to_s}: Running job #{message.body}...")
      else jabber.deliver(message.from, "I don't know anything about #{message.body}")
      end
    end
  end
end
