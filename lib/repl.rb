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
    while command != "quit"
      printf "Enter command: "
      input = gets.chomp
      parts = input.split(" ")

      if parts[0] == "queue" && parts[1] == "save" && parts[2] == "to"
        command = parts[0..2].join(" ")
      elsif parts[0] == "queue" && parts[1] == "print" && parts[2] == "by"
        command = parts[0..2].join(" ")
      elsif parts[0] == "queue" && parts[1] == "export" && parts[2] == "html"
        command = parts[0..2].join(" ")
      elsif parts[0] == "queue"
        command = parts[0..1].join(" ")
      else
        command = parts[0]
      end

      case command
        when "quit" then puts "Quitting"
        when "load" then attendees = Attendees.new(parts[1])
        when "find" then
          if attendees == nil
          else
            @queue.add_to_queue(attendees,parts[1], parts[2..-1].join(" "))
          end
        when "queue count" then p @queue.count_queue
        when "queue clear" then @queue.clear_queue
        when "help" then p HelpModule::help(parts[1..-1])
        when "queue print" then @queue.print_queue_to_terminal
        when "queue print by" then @queue.sort_by_attribute(parts[3])
        when "queue district" then
          if @queue.count_queue > 10
            p "Please ensure queue has 10 or less items"
          else
            @queue.set_district
          end
        when "queue save to" then FileGenerator::create_csv(parts[3], @queue.queue)
        when "queue export html" then FileGenerator::create_html(parts[3], @queue.queue)
      end
    end
  end

end
Repl.new.repl
