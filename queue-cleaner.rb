#!/usr/bin/env ruby
# frozen_string_literal: true
# Default app path: /home/asterisk/bin/queue-cleaner.rb

require 'logger'
require 'ruby-asterisk'
ASTER = '127.0.0.1'
PORT = 5038
USER = 'someuser'
PASS = 'somepassword'
CONT = 'from-internal'
DEBUG = true

begin
  logger = Logger.new('/var/log/asterisk/queue-cleaner.log', 'monthly')

  @ami = RubyAsterisk::AMI.new(ASTER, PORT)
  @ami.login(USER, PASS)

  # console, log
  def message(word, logging)
    p word if DEBUG
    logging.info word
  end

  message 'App started! ', logger

  c = @ami.command('core show calls')
  message c.data.split("\n").join(', '), logger

  q = @ami.queue_status
  message q.message, logger

  resp = q.data.split("\n")

  agents = []
  queues = []

  resp.each do |r|
    agents << r if r.include? 'Location'
    queues << r if r.include? 'Queue:'
  end

  agents.uniq!
  queues.uniq!
  queues.delete('Queue: default')

  queues.each do |queue|
    queue.sub!('Queue: ', '')
    agents.each do |agent|
      agent.sub!('Location: ', '')
      sleep(1)
      remove = @ami.queue_remove(queue.to_s, agent.to_s)
      message "Queue: #{queue}, Agent: #{agent}, Response: #{remove.message}", logger
    end
  end

  message 'App finished!', logger
rescue StandardError => e
  message e, logger
end
