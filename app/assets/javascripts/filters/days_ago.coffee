angular.module('RestaurantPosWeb').filter 'days_ago', ($filter) ->
  (date) ->
    number_of_days = moment().diff date, 'days'

    if number_of_days == 0
      return 'Today'

    if number_of_days == 1
      return "Yesterday"

    if number_of_days < 7
      return "#{number_of_days} days ago"

    if number_of_days < 30
      return "#{Math.round(number_of_days/7)} weeks ago"

    else
      return "#{Math.round(number_of_days/30)} months ago"
