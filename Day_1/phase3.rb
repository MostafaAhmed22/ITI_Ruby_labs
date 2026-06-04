
class BaseHandler
  def process(event)
    raise "implement process"
  end
end

class ScreenHandler < BaseHandler
  def process(event)
    puts "log: #{event}"
  end
end

class LogHandler < BaseHandler
  def initialize(log_path = "events.log")
    @log_path = log_path
  end

  def process(event)
    File.open(@log_path, "a") { |f| f.puts "#{Time.now}: #{event}" }
  end
end

class EventHub
  def initialize
    @listeners = []
  end

  def subscribe(listener)
    @listeners << listener
  end

  def trigger(event)
    @listeners.each { |listener| listener.process(event) }
  end
end

hub = EventHub.new
hub.subscribe(ScreenHandler.new)
hub.subscribe(LogHandler.new)

loop do
  puts "\n=== lifetrack ==="
  puts "1. work session"
  puts "2. study session"
  puts "3. exercise session"
  puts "4. meal"
  puts "5. exit"
  print "> "

  selection = gets.to_i

  case selection
  when 1
    print "duration (min)? "
    minutes = gets.to_i
    hub.trigger("work: #{minutes} mins")
  when 2
    print "topic? "
    subject = gets.strip
    hub.trigger("study: #{subject}")
  when 3
    print "exercise type? "
    activity = gets.strip
    hub.trigger("exercise: #{activity}")
  when 4
    print "meal type? "
    food_type = gets.strip
    hub.trigger("meal: #{food_type}")
  when 5
    puts "goodbye!"
    break
  else
    puts "invalid choice"
  end
end
