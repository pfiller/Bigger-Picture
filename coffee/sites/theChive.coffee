class theChive

  constructor: () ->
    containers = $(".gallery-icon")
    images = []

    for container in containers
      container = $(container)
      image_el = container.find("img").first()

      images.push {
        image_el
        src: image_el.attr("src").split("?")[0]
        caption: container.next(".gallery-caption").text()
      }

    console.dir images
    new BiggerPicture.Gallery(images)

new theChive()
