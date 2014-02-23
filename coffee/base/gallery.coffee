
window.BiggerPicture or= {}

class BiggerPicture.Gallery

  slides: []

  container: $("<div />", { class: "bigger-picture" })

  constructor: (images) ->
    $("body").addClass("bigger-picture-active").append(@container)

    @set_up_image(image, i) for image, i in images
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

  test_keypress: (evt) =>
    switch evt.keyCode
      when 39, 40
        evt.preventDefault()
        @set_current(@current_index + 1) if @current_index < @slides.length - 1
      when 37, 38
        evt.preventDefault()
        @set_current(@current_index - 1) if @current_index > 0
      when 27
        evt.preventDefault()
        @remove()

  trigger_resize: () =>
    @slides[@current_index].set_image_size_for_display()
