
$(document).on 'click', "@sharing_tags_share", (event) ->
    event.preventDefault()
    self = $(@)
    SharingTags.share(
      self.data('network'),
      mobile:  device?.mobile()  # for mobile devices
      page_url: self.attr("href")
      url:     self.data 'share-url'
      title:   self.data 'title'
      message: self.data 'description'
      image:   self.data 'image'
    )
