
window.BiggerPicture or= {}

class BiggerPicture.Gallery

  slides: []

  container: $("<div />", { class: "bigger-picture" })

  constructor: (images) ->
    $("body").addClass("bigger-picture-active").append(@container)

    @set_up_image(image) for image in images

    @set_up_listeners()
    @set_current()

    window.onresize = @trigger_resize

  remove: () ->
    $("body").removeClass("bigger-picture-active")
    @container.remove()
    delete @slides

  set_up_image: (image) ->
    @slides.push new BiggerPicture.Slide(image, @container) if image.src

  set_current: (to = 0) ->
    window.scroll(0, 0)
    @hide_current() if @current_index?
    @current_index = to
    @slides[@current_index].show_slide()

  hide_current: () ->
    @slides[@current_index].hide_slide()

  set_up_listeners: () ->
    $("body").on("keydown", @test_keypress)

  test_keypress: (evt) =>
    switch evt.keyCode
      when 39, 40
        evt.preventDefault()
        @set_current(if @current_index < @slides.length - 1 then @current_index + 1 else 0)
      when 37, 38
        evt.preventDefault()
        @set_current(if @current_index > 0 then @current_index - 1 else @slides.length - 1)
      when 27
        evt.preventDefault()
        @remove()

  trigger_resize: () =>
    @slides[@current_index].set_image_size_for_display()
