BiggerPicture = BiggerPicture or {}

class BiggerPicture.App

  constructor: () ->
    images = $(".bpImageTop, .bpBoth")
    ss = new BiggerPicture.Gallery(images)

setTimeout () ->
    new BiggerPicture.App()
  0
