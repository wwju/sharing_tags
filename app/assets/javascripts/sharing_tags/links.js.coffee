
$(document).on 'click', "@sharing_tags_share", (event) ->
    event.preventDefault()
    self = $(@)
    network = self.data('network')
    context = self.data('context')
    jQuery?("body").trigger(type: "sharing_tags.click_action", network: network, context: context, target: self)

    SharingTags.share(
      network,
      mobile:  device?.mobile()  # for mobile devices
      page_url: self.attr("href")
      url:     self.data 'share-url'
      title:   self.data 'title'
      message: self.data 'description'
      image:   self.data 'image'
      app_id:  self.data 'app-id'
    )
