angular.module('RestaurantPosWeb')
.config ($stateProvider) ->
  $stateProvider.state('login',
    url: ''
    views:
      dashboard:
        templateUrl: '/templates/devise/sessions/new'
        controller: 'UsersController as users_ctrl'

    resolve:
      auth: ($auth, $state) ->
        $auth.validateUser().then( ->
          $state.go 'app.restaurant'
        ).catch ->

  ).state('login.with_slaash',
    url: '/'

  ).state('app',
    abstract: true
    template: '<ui-view/>'
    resolve:
      app: ($auth, $state) ->
        $auth.validateUser().catch ->
          $state.go 'login'

    views:
      menu:
        templateUrl: '/templates/menu/index'
  ).state('app.restaurant'
    views:
      'dashboard@':
        templateUrl: '/templates/restaurant/index'
        controller: 'DashboardController as dashboard_ctrl'
  )
