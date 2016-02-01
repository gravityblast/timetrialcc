class CountDownWidget extends BaseWidget
  init: ->
    @element.countdown @options.time, (event) ->
      $(this).html(event.strftime('%w weeks %d days %H:%M:%S'))
    @element.on 'finish.countdown', =>
      @element.hide()
      document.location = document.location

Widgets.register 'countdown', CountDownWidget
