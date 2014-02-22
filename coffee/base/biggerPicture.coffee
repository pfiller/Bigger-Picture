BiggerPicture = BiggerPicture or {}

class BiggerPicture.App

  constructor: () ->
    images = $(".bpImageTop, .bpBoth")
    $("body").html("")
    ss = new BiggerPicture.Gallery(images)

setTimeout () ->
    new BiggerPicture.App()
  0
