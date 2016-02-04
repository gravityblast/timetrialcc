class SlideLinksWidget extends BaseWidget
  init: ->
    $('.slide-link', @element).on 'click', @clickHandler

  clickHandler: (event) =>
    event.preventDefault()
    hash = event.currentTarget.hash
    target = $ hash
    options =
      scrollTop: target.offset().top
    $('hmtl, body').animate options, 300, ->
      window.location.hash = hash

Widgets.register 'slide-links', SlideLinksWidget
