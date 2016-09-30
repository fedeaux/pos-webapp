angular.module('RestaurantPosWeb').filter 'percentage', [
  '$filter'
  ($filter) ->
    (input) ->
      input_100 = input * 100
      input_100_i = Math.floor input_100
      decimals = 0

      if (input_100 - input_100_i) > 0.1
        decimals = 1
      else if (input_100 - input_100_i) > 0.01
        decimals = 2

      $filter('number')(input_100, decimals) + '%'
]
