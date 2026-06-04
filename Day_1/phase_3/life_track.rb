require_relative 'life_event'
require_relative 'event_router'
require_relative 'console_handler'
require_relative 'file_handler'
require_relative 'html_dashboard_handler'

class LifeTrack
  def initialize
    @router = EventRouter.new
    @router.add_handler(ConsoleHandler.new)
    @router.add_handler(FileHandler.new)
    @router.add_handler(HtmlDashboardHandler.new)
  end

  def run
    puts "=== LifeTrack ==="

    loop do
      print_menu
      choice = gets.chomp.to_i

      case choice
      when 1
        log_event('Work')
      when 2
        log_event('Study')
      when 3
        log_event('Exercise')
      when 4
        log_event('Meal')
      when 5
        puts "Exiting LifeTrack. Goodbye!"
        break
      else
        puts "Invalid option. Please choose 1-5."
      end
    end
  end

  private

  def print_menu
    puts "\n1. Log a work session"
    puts "2. Log a study session"
    puts "3. Log an exercise session"
    puts "4. Log a meal"
    puts "5. Exit\n\n"
    print "Choose an option: "
  end

  def log_event(type)
    print "Description: "
    description = gets.chomp
    print "Duration (minutes): "
    duration_input = gets.chomp

    # basic validation
    duration = duration_input.to_i
    if duration <= 0
      puts "Invalid duration. Event not logged."
      return
    end

    event = LifeEvent.new(type, description, duration)
    @router.dispatch(event)

    puts "\u2713 Event logged."
  end
end

if __FILE__ == $0
  app = LifeTrack.new
  app.run
end
