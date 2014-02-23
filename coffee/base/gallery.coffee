
window.BiggerPicture or= {}

class BiggerPicture.Gallery

  slides: []

  container: $("<div />", { class: "bigger-picture" })

  constructor: (@images) ->
    clicker = document.createElement("div")
    clicker.className = "bigger-clicker"
    document.querySelector("body").appendChild(clicker)
    clicker.addEventListener("click", @handle_clicker_click)

  handle_clicker_click: () =>
    $("body").addClass("bigger-picture-active").append(@container)

    @set_up_image(image, i) for image, i in @images
    @set_up_listeners()

  remove: () ->
    $("body").removeClass("bigger-picture-active")
    @container.remove()
    delete @slides

  set_up_image: (image, i) ->
    image.index = i
    @slides.push new BiggerPicture.Slide(image, @container) if image.src
    @set_current(0)

  set_current: (@current_index) ->
    slide.update_position(@current_index) for slide in @slides
    window.setTimeout (() -> window.scrollTo(0, 0)), 0

  set_up_listeners: () ->
    window.onresize = @trigger_resize
    $("body").on("keydown", @test_keypress)
    @container.on("click", ".bigger-picture-right-thumb", @nav_right)
    @container.on("click", ".bigger-picture-left-thumb", @nav_left)

  nav_right: (evt) =>
    evt?.preventDefault()
    @set_current(@current_index + 1) if @current_index < @slides.length - 1

  nav_left: (evt) =>
    evt?.preventDefault()
    @set_current(@current_index - 1) if @current_index > 0

  test_keypress: (evt) =>
    switch evt.keyCode
      when 39, 40 then @nav_right(evt)
      when 37, 38 then @nav_left(evt)
      when 27
        evt.preventDefault()
        @remove()

  trigger_resize: () =>
    @slides[@current_index].set_image_size_for_display()

    clearTimeout(@resize_timeout)
    @resize_timeout = setTimeout(@resize_all_images, 100)

  resize_all_images: () =>
    slide.set_image_size_for_display() for slide in @slides
