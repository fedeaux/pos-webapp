@DateFormats =
  db_day: 'YYYY-MM-DD'
  pretty_day: 'ddd, MMM Do'

angular.module('RestaurantPosWeb', ['ngResource', 'ui.router', 'ng-token-auth'])
  .config ($authProvider) ->
    $authProvider.configure
      apiUrl: config.api_url
      storage: 'localStorage'

init = ->
  angular.bootstrap( $('body'), ['RestaurantPosWeb'] )

$(document).on 'page:load', init
$(document).ready init
