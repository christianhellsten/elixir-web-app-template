class Flash
  constructor: (@flash_holder, @cookie_prefix) ->
    @flash_holder ?= '#flash'
    @cookie_prefix ?= 'flash_'

  show: ->
    for key in ['info', 'error']
      # Read cookie, e.g. flash_info
      name = @cookie_prefix + key
      value = $.cookie(name)
      if value
        console.debug("Flash #{name} = #{key}")
        # Set flash holder contents to cookie value
        $(@flash_holder).append("""<span class="flash_#{key}">#{value}</span>""").show()
        $.removeCookie(name, path: '/')

$ ->
  new Flash().show()

window.Flash = Flash
