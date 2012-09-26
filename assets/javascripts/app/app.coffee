require 'travis' # hrm.
require 'auth'
require 'controllers'
require 'helpers'
require 'models'
require 'pusher'
require 'routes'
require 'slider'
require 'store'
require 'tailing'
require 'templates'
require 'views'

require 'config/locales'
require 'data/sponsors'

# $.mockjaxSettings.log = false
# Ember.LOG_BINDINGS = true
# Ember.ENV.RAISE_ON_DEPRECATION = true
Pusher.log = -> console.log(arguments)

Travis.reopen
  App: Em.Application.extend
    currentUserBinding: 'auth.user'
    accessTokenBinding: 'auth.user.accessToken'
    authStateBinding: 'auth.state'

    initialize: ->
      @_super()

    init: ->
      @_super()

      @store = Travis.Store.create()
      @store.loadMany(Travis.Sponsor, Travis.SPONSORS)

      @set('auth', Travis.Auth.create(store: @store, endpoint: Travis.config.api_endpoint))

      @slider = new Travis.Slider()
      @routes = new Travis.Routes()

      @pusher = new Travis.Pusher()
      @tailing = new Travis.Tailing()

    signIn: ->
      @get('auth').signIn()

    signOut: ->
      @get('auth').signOut()
      @routes.route('')

    render: (name, action, params) ->
      layout = @connectLayout(name)
      layout.activate(action, params || {})
      $('body').attr('id', name)

    receive: ->
      @store.receive.apply(@store, arguments)

    toggleSidebar: ->
      $('body').toggleClass('maximized')
      # TODO gotta force redraws here :/
      element = $('<span></span>')
      $('#top .profile').append(element)
      Em.run.later (-> element.remove()), 10
      element = $('<span></span>')
      $('#repository').append(element)
      Em.run.later (-> element.remove()), 10

