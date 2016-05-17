# http://brunch.io/#documentation
exports.config =
  files:
    javascripts:
      joinTo: 'js/app.js'
      order:
        before: ['js/vendor']
    stylesheets:
      joinTo: 'css/app.css'
      order:
        before: ['css/vendor']
    templates:
      joinTo: 'js/app.js'
  conventions:
    assets: /^(web\/assets)/
  paths:
    watched: [
      'web'
      'test/web'
    ]
    public: 'public'
  plugins:
    babel:
      ignore: [ /web\/vendor/ ]
    cleancss:
      keepSpecialComments: 0
      removeEmpty: true
    uglify:
      mangle: false
      compress:
        global_defs:
          DEBUG: false
  modules:
    autoRequire: 'js/app.js': [ 'web/js/app' ]
