class EventsTracker extends BaseWidget
  init: ->
    trackEvent = if ga? then @trackGAEvent else @logEvent
    events =  @element.data 'events'
    trackEvent event for event in events

  trackGAEvent: (event) ->
    ga 'send', 'event', event.c, event.a, event.l, event.v

  logEvent: (event) ->
    console.log "Track event: #{event.c}, #{event.a}, #{event.l}, #{event.v}"


Widgets.register 'events-tracker', EventsTracker
