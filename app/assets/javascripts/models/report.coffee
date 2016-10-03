angular.module('RestaurantPosWeb').factory 'Report', ($resource) ->
  class Report
    constructor: (attributes = {}) ->
      @setAttributes attributes

      # angular checklist-model breaks the usual form <-> list flow.
      # this variable is a workaround
      @model = true

    setAttributes: (attributes) ->
      for name, default_value of @defaultAttributes()
        if attributes.hasOwnProperty(name) and attributes[name] != null
          @[name] = attributes[name]
        else
          @[name] = default_value

      @updateAuxiliarAttributes()

    updateAuxiliarAttributes: ->
      @moment_start = moment @start
      @formatted_start = @moment_start.format(DateFormats.day_month_and_year)

      @moment_finish = moment @finish
      @formatted_finish = @moment_finish.format(DateFormats.day_month_and_year)

      @moment_created_at = moment @created_at
      @formatted_created_at = @moment_created_at.format(DateFormats.day_month_and_year)

      @moment_updated_at = moment @updated_at
      @formatted_updated_at = @moment_updated_at.format(DateFormats.day_month_and_year)

      @list_reporters = @reporters.map((reporter) ->
        parts = reporter.split('::')
        parts[parts.length - 1]
      ).join ', '

    isPersisted: ->
      !! @id

    defaultAttributes: ->
      attr =
        id: null
        reporters: []
        start: null
        finish: null

      attr

    attributes: ->
      attr = {}

      for name, default_value of @defaultAttributes()
        attr[name] = @[name]

      attr.start = attr.start[1]
      attr.finish = attr.finish[1]

      attr
