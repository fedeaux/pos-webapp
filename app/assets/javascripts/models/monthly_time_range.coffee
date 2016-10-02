angular.module('RestaurantPosWeb').factory 'MonthlyTimeRange', ->
  class MonthlyTimeRange
    constructor: (@earliest, @latest) ->
      @create_month_options()

    create_month_options: ->
      @start_options = []
      @finish_options = []

      start = @earliest.clone().startOf 'month'
      finish = @latest.clone().endOf 'month'

      current = start.clone()

      while current < finish
        @start_options.push [current.format(DateFormats.day_month_and_year), current.format(DateFormats.db_day)]
        current_finish = current.clone().endOf 'month'
        @finish_options.push [current_finish.format(DateFormats.day_month_and_year), current_finish.format(DateFormats.db_day)]
        current.add 1, 'month'
