require_relative 'handler'

class FileHandler < Handler
  def initialize(filepath = 'events.log')
    @filepath = filepath
  end

  def handle(event)
    File.open(@filepath, 'a') do |f|
      f.puts "[#{event.formatted_time}] #{event.type.upcase} \u2014 #{event.description} (#{event.duration} min)"
    end
  end
end
