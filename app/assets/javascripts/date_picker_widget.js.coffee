class DatePickerWidget extends BaseWidget
  init: ->
    now = new Date()
    now.setDate(now.getDate() + 1)
    date = new Date now

    @dateField = $('.date-picker-field', @element)
    @timestampField = $('.timestamp-field', @element)
    @dateField.datetimepicker(
      defaultDate: date,
      locale: navigator.language
    )

    @dateField.on 'dp.change', @dateFieldChangeHandler
    @setTimestap()

  dateFieldChangeHandler: =>
    @setTimestap()

  setTimestap: ->
    timestamp = @dateField.data("DateTimePicker").date().utc().unix()
    console.log @timestampField
    @timestampField.val timestamp

Widgets.register 'date-picker', DatePickerWidget
