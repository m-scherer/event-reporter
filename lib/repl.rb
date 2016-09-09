require "./lib/attendees"
require "./lib/queue"
require "./lib/help_module"
require "./lib/file_generator"
require "pry"

class Repl

  def initialize
    @queue = Queue.new
  end
  
  def repl
    puts "Welcome to the Event-Reporter project!"
    command = ""
    while command != "quit"
      printf "Enter command: "
      input = gets.chomp
      parts = input.split(" ")
      command = command_parser(input)
      case command
      when "quit" then puts "Goodbye!"
      when "load" then @attendees = Attendees.new(parts[1])
        puts "#{parts[1]} loaded!"
      when "find" then find_command(@attendees, parts)
      when "queue count" then puts "Count: #{@queue.count_queue}"
      when "queue clear" then @queue.clear_queue
        puts "Queue cleared!"
      when "help" then HelpModule.send(parts[0..-1].join("_"))
      when "queue print" then @queue.print_queue_to_terminal
      when "queue print by" then @queue.sort_by_and_print_call(parts[3])
      when "queue district" then district_queuer
      when "queue save to" then FileGenerator.create_csv(parts[3], @queue.queue)
        puts "Queue saved to #{parts[3]}"
      when "queue export html" then FileGenerator.create_html(parts[3], @queue.queue)
        puts "Queue exported to #{parts[3]}"
      when "add" then queue_adder(parts)
      when "subtract" then queue_subtracter(parts)
      else
        puts "Please enter a valid command"
      end
    end
  end

  def command_parser(input)
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
  end

  def find_command(attendees, parts)
    if @attendees != nil
      @queue.add_to_queue(attendees,parts[1], parts[2..-1].join(" "))
      puts "Found #{@queue.count_queue} records!"
    end
  end

  def district_queuer
    if @queue.count_queue > 10
      p "Please ensure queue has 10 or less items"
    else
      @queue.set_district
      puts "Districts set!"
    end
  end

  def queue_adder(parts)
    if @attendees != nil
      @queue.queue_math_add(@attendees,parts[1], parts[2..-1].join(" "))
    end
  end

  def queue_subtracter(parts)
    if @attendees != nil
      @queue.queue_math_subtract(@attendees,parts[1], parts[2..-1].join(" "))
    end
  end

end
Repl.new.repl
