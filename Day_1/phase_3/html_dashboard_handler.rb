require_relative 'handler'

class HtmlDashboardHandler < Handler
  ParsedEvent = Struct.new(:formatted_time, :type, :description, :duration)

  def initialize(filepath = 'index.html', logpath = 'events.log')
    @filepath = filepath
    @logpath = logpath
    @events = load_previous_events
    generate_html # generate initially to show loaded events
  end

  def handle(event)
    @events << event
    generate_html
  end

  private

  def load_previous_events
    events = []
    return events unless File.exist?(@logpath)
    
    File.readlines(@logpath).each do |line|
      # Format: [2026-06-04 20:41] STUDY — Studied ruby in ITI (60 min)
      if line =~ /^\[(.*?)\] (.*?) \u2014 (.*?) \((\d+) min\)$/
        events << ParsedEvent.new($1, $2, $3, $4.to_i)
      end
    end
    events
  end

  def generate_html
    html = <<-HTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>LifeTrack Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background: linear-gradient(180deg, #eef2ff 0%, #ffffff 100%); color: #212529; }
    .card { border: none; border-radius: 1rem; }
    .card-body { background-color: #ffffff; }
    .card-title { color: #2c3e50; }
    .event-card { margin-bottom: 1rem; border-left: 6px solid; box-shadow: 0 8px 18px rgba(15, 23, 42, 0.08); }
    .event-work { border-left-color: #0d6efd; }
    .event-study { border-left-color: #6610f2; }
    .event-exercise { border-left-color: #20c997; }
    .event-meal { border-left-color: #fd7e14; }
    .event-default { border-left-color: #6c757d; }
  </style>
</head>
<body>
  <div class="container mt-5">
    <h1 class="mb-4">LifeTrack Dashboard</h1>
    <div class="row">
      <div class="col-12">
        <div class="card shadow-sm">
          <div class="card-body">
            <h5 class="card-title">Recent Events</h5>
            <p class="text-muted small">Total events: #{@events.count}</p>
            <hr>
            #{render_events}
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
    HTML

    File.write(@filepath, html)
  end

  def render_events
    if @events.empty?
      return "<p class='text-muted'>No events logged yet.</p>"
    end

    @events.reverse.map do |event|
      css_class = "event-#{event.type.downcase}"
      css_class = 'event-default' unless %w[work study exercise meal].include?(event.type.downcase)
      <<-HTML
      <div class="card event-card #{css_class}">
        <div class="card-body py-2">
          <div class="d-flex justify-content-between align-items-center">
            <div>
              <strong class="text-uppercase">#{event.type}</strong> &mdash; #{event.description}
            </div>
            <div class="text-muted small">
              #{event.formatted_time} &bull; <span class="badge bg-secondary">#{event.duration} min</span>
            </div>
          </div>
        </div>
      </div>
      HTML
    end.join("\n")
  end
end
