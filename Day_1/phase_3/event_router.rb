class EventRouter
  def initialize
    @handlers = []
  end

  def add_handler(handler)
    @handlers << handler
  end

  def dispatch(event)
    @handlers.each do |handler|
      handler.handle(event)
    end
  end
end
