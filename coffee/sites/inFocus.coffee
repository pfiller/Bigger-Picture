class inFocus

  constructor: () ->
    containers = $(".if1280 .ifWrp")
    images = []

    for container in containers
      container = $(container)
      image_el = container.find("img").first()

      images.push {
        image_el
        src: image_el.attr 'src'
        caption: container.find(".imgCap").remove("a").text()
      }

    console.log "WTF"
    console.dir images
    new BiggerPicture.Gallery(images)

new inFocus()
