BiggerPicture = BiggerPicture or {}

class BiggerPicture.Gallery

  slides: []
  current_index: 0

  container: $("<div />", { class: "bigger-picture" })
  overlay: $("<div />", { class: "bigger-picture-overlay" })
  ul: $("<ul />", { class: "bigger-picture-list" })

  constructor: (images) ->
    @container.append(@overlay, @ul)
    $("body").append(@container)

    @set_up_image(image) for image in images

    @set_up_listeners()
    @show_current()

  set_up_image: (image) ->
    list_image = $("<li >").hide()
    @ul.append(list_image)
    @slides.push new BiggerPicture.Slide(image, list_image)

  show_current: () ->
    @slides[@current_index].show_slide()

  hide_current: () ->
    @slides[@current_index].hide_slide()

  set_up_listeners: () ->
    $("body").on("keydown", (evt) => @test_keypress(evt))

  test_keypress: (evt) ->
    kc = evt.keyCode
    to = -9999
    if(kc in [39, 40])
      to = if @current_index < @slides.length - 1 then @current_index + 1 else 0
    else if(kc in [37, 38])
      to = if @current_index > 0 then @current_index - 1 else @slides.length - 1

    if to >= 0
      evt.preventDefault()
      @hide_current()
      @current_index = to
      @show_current()
