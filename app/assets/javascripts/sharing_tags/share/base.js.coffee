class @SharingTags.BaseShare

  url: null
  title: null
  description: null

  constructor: ({@url, @title, @description})->
    @_assert_vars 'url'

  _open_popup: (api_url, params)->
    share_url = if params then "#{api_url}?#{$.param(params)}" else api_url
    share_window = window.open share_url, 'Sharing', 'width=740,height=440'

    clearInterval(@interval)
    iteration = 0
    @interval = setInterval((=>
      iteration++
      if @_checkSharing(share_url, share_window, iteration)
        clearInterval @interval
        jQuery("body").trigger("sharing_tags.shared") if jQuery
    ), 500)

  _checkSharing: (share_url, share_window, iteration)=>
    # console.log("check desktop sharing", share_url, share_window, iteration)
    share_window?.closed || iteration >= 15

  _after_callback: =>
    jQuery?("body").trigger("sharing_tags.shared")

  _assert_vars: (vars...)->
    for var_name in vars
      if ! @[var_name]
        arguments_list = ''
        arguments_list += " #{var_name}: '#{@[var_name]}'" for arg, val in vars
        throw new SharingTags.Error("Error could not initialize sharing class, with params: #{arguments_list}")

  _user_agent: ->
    window.navigator?.userAgent