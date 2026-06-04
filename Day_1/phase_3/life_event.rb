class LifeEvent
  attr_reader :timestamp, :type, :description, :duration

  def initialize(type, description, duration)
    @timestamp = Time.now
    @type = type
    @description = description
    @duration = duration
  end

  def formatted_time
    @timestamp.strftime("%Y-%m-%d %H:%M")
  end
end
