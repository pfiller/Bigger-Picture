class BigPicture

  constructor: () ->
    containers = $(".bpBody, .bpImageTop, .bpBoth, .t402-elided-image.bpImage")
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
    new BigPicture()
  0
