require_relative 'handler'

class ConsoleHandler < Handler
  def handle(event)
    puts "\n[#{event.formatted_time}] #{event.type.upcase} \u2014 #{event.description} (#{event.duration} min)"
  end
end
