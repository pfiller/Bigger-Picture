BiggerPicture = BiggerPicture or {}

class BiggerPicture.Slide

  constructor: (@image, @element) ->
    @list = @element.parents("ul")

    @img = new Image()
    @img.addEventListener "load", @image_loaded
    @img.src = @image.src

    @element.append(@img)

  set_image_size_for_display: () ->
    list_height = @list.height()
    list_width = @list.width()

    if @raw_image_height > list_height or @raw_image_width > list_width
      scale = if @raw_image_width > @raw_image_height then list_width / @raw_image_width else list_height / @raw_image_height
    else
      scale = 1

    @img.width = Math.floor(@raw_image_width * scale)
    @img.height = Math.floor(@raw_image_height * scale)

  image_loaded: =>
    @raw_image_height = @img.height
    @raw_image_width = @img.width

    @loaded = true
    @show_slide() if @pending_show

  show_slide: () ->
    if not @loaded
      @pending_show = true
      return

    @set_image_size_for_display()
    @element.fadeIn("fast")
    @pending_show = false

  hide_slide: () ->
    @element.fadeOut("fast")
