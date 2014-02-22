BiggerPicture = BiggerPicture or {}

class BiggerPicture.App

  constructor: () ->
    containers = $(".bpImageTop, .bpBoth")
    images = []

    for container in containers
      container = $(container)
      image_el = container.find("img").first()

      images.push {
        image_el
        src: image_el.attr 'src'
        caption: container.find(".bpCaption").remove("a, div").text()
      }

    new BiggerPicture.Gallery(images)

setTimeout () ->
    new BiggerPicture.App()
  0
