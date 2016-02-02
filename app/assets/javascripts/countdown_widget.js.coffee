class CountDownWidget extends BaseWidget
  init: ->
    @countdownElement = $ '.countdown', @element
    @waitingElement   = $ '.waiting', @element
    now = new Date()
    endTime = new Date(@options.time)
    if now >= endTime
      @countdownElement.hide()
      @waitingElement.show()
    else
      @startTimer()

  startTimer: ->
    @countdownElement.countdown @options.time, (event) ->
      $(this).html(event.strftime('%w weeks %d days %H:%M:%S'))
    @countdownElement.on 'finish.countdown', =>
      @element.hide()
      document.location = document.location

Widgets.register 'countdown', CountDownWidget
