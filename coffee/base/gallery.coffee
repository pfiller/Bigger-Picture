BiggerPicture = BiggerPicture or {}

class BiggerPicture.Gallery

  slides: []

  container: $("<div />", { class: "bigger-picture" })
  overlay: $("<div />", { class: "bigger-picture-overlay" })
  ul: $("<ul />", { class: "bigger-picture-list" })

  constructor: (images) ->
    @container.append(@overlay, @ul)
    $("body").append(@container)

    @set_up_image(image) for image in images

    @set_up_listeners()
    @set_current()

    window.onresize = @trigger_resize

  set_up_image: (image) ->
    list_image = $("<li >").hide()
    @ul.append(list_image)
    @slides.push new BiggerPicture.Slide(image, list_image)

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
    evt.preventDefault()

    switch evt.keyCode
      when 39, 40
        evt.preventDefault()
        @set_current(if @current_index < @slides.length - 1 then @current_index + 1 else 0)
      when 37, 38
        evt.preventDefault()
        @set_current(if @current_index > 0 then @current_index - 1 else @slides.length - 1)

  trigger_resize: () =>
    @slides[@current_index].set_image_size_for_display()
