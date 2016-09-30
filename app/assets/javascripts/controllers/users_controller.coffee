class UsersController
  constructor: (@scope, @state, @auth, @timeout) ->
    @credentials = {
      email: '',
      password: ''
    }

  login: ->
    @auth.submitLogin(@credentials).then((user) =>
      @state.go 'app.restaurant'
    ).catch (error) ->
      console.log error

  logout: ->
    @auth.signOut().then( =>
      @timeout =>
        @state.go 'login'
    )

UsersController.$inject = ['$scope', '$state', '$auth', '$timeout']
angular.module('RestaurantPosWeb').controller 'UsersController', UsersController
