require "./lib/attendees"
require "./lib/queue"
require "./lib/help_module"
require "./lib/file_generator"
require "pry"

class Repl
  include HelpModule
  include FileGenerator

  def initialize
    @queue = Queue.new
  end

  def repl
    command = ""
    while command != "q"
      printf "Enter command: "
      input = gets.chomp
      parts = input.split(" ")

      if parts[0] == "queue"
        command = parts[0..1].join(" ")
      elsif part

      else
        command = parts[0]
      end

      case command
        when 'q' then puts "Quitting"
        when "load" then attendees = Attendees.new
        when "find" then @queue.add_to_queue(attendees,parts[1], parts[2])
        when "queue count" then p @queue.count_queue
        when "queue clear" then @queue.clear_queue
        when "help" then p HelpModule::help(parts[1])
        when "queue print" then
        when "queue district" then
        when "queue save to" then FileGenerator::create_csv(parts[2], @queue.queue)
        when "queue export html" then



      end
    end
  end

end
