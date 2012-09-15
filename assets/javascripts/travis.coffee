require 'ext/jquery'
require 'ext/ember/namespace'

@Travis = Em.Namespace.create
  config:
    api_endpoint: $('meta[rel="travis.api_endpoint"]').attr('href')
    pusher_key:   $('meta[name="travis.pusher_key"]').attr('content')

  CONFIG_KEYS: ['rvm', 'gemfile', 'env', 'jdk', 'otp_release', 'php', 'node_js', 'perl', 'python', 'scala']

  ROUTES:
    'profile':                     ['profile', 'hooks']
    'profile/:login':              ['profile', 'hooks']
    'profile/:login/profile':      ['profile', 'user']
    'stats':                       ['stats', 'show']
    ':owner/:name/jobs/:id/:line': ['home', 'job']
    ':owner/:name/jobs/:id':       ['home', 'job']
    ':owner/:name/builds/:id':     ['home', 'build']
    ':owner/:name/builds':         ['home', 'builds']
    ':owner/:name/pull_requests':  ['home', 'pullRequests']
    ':owner/:name/branches':       ['home', 'branches']
    ':owner/:name':                ['home', 'current']
    '':                            ['home', 'index']

  QUEUES: [
    { name: 'common',  display: 'Common' }
    { name: 'php',     display: 'PHP, Perl and Python' }
    { name: 'node_js', display: 'Node.js' }
    { name: 'jvmotp',  display: 'JVM and Erlang' }
    { name: 'rails',   display: 'Rails' }
    { name: 'spree',   display: 'Spree' }
  ]

  INTERVALS: { sponsors: -1, times: -1, updateTimes: 1000 }

  run: (attrs) ->
    console.log "Connecting to #{Travis.config.api_endpoint}"
    app = Travis.App.create(attrs || {})
    # TODO: router expects the classes for controllers on main namespace, so
    #       if we want to keep app at Travis.app, we need to copy that, it would
    #       be ideal to send a patch to ember and get rid of this
    $.each Travis, (key, value) ->
      app[key] = value if value && value.isClass && key != 'constructor'

    @app   = app
    @store = app.store

    app.initialize()

