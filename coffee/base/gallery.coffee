BiggerPicture = BiggerPicture or {}

class BiggerPicture.Gallery

  slides: []
  current_index: 0

  container: $("<div />", { class: "bigger-picture" })
  overlay: $("<div />", { class: "bigger-picture-overlay" })
  ul: $("<ul />", { class: "bigger-picture-list" })

  constructor: (images) ->
    @set_up_image(image) for image in images
    @container.append(@overlay, @ul)
    $("body").append(@container)
    @set_up_listeners()
    @show_current()

  set_up_image: (image) ->
    image = $(image)
    src = image.find(".bpImage").first().prop("src")
    caption = image.find(".bpCaption")

    caption.find(".photoNum").remove()
    caption.find(".cf, a").remove()
    caption = caption.text()

    id = "slide-#{@slides.length}"
    @ul.append($("<li >",{id: id}))
    @slides.push new BiggerPicture.Slide( src, caption, id )

  show_current: () ->
    @slides[@current_index].show_slide( $(window).height(), $(window).width())

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
