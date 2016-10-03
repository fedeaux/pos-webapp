@DateFormats =
  db_day: 'YYYY-MM-DD'
  pretty_day: 'ddd, MMM Do'
  day_month_and_year: 'MMM Do, YYYY'

angular.module('RestaurantPosWeb', ['ngResource', 'ngMessages', 'ui.router', 'ng-token-auth', 'checklist-model' ])
  .config ($authProvider) ->
    $authProvider.configure
      apiUrl: config.api_url
      storage: 'localStorage'

init = ->
  angular.bootstrap( $('body'), ['RestaurantPosWeb'] )

$(document).on 'page:load', init
$(document).ready init
