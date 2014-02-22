BiggerPicture = BiggerPicture or {}

class BiggerPicture.Slide

  constructor: (@image, @element) ->
    @img = new Image()
    @img.addEventListener "load", @image_loaded
    @img.src = @image.src

    @element.append(@img)

  get_resize_dimensions: (w,h) ->
    window_height = $(window).height
    window_width = $(window).width

    if window_width > w or window_height > h
      scale = if window_width/w < window_height/h then window_width/w else window_height/h
      {
        w: Math.floor(w * scale)
        h: Math.floor(h * scale)
      }
    else
      {w: w, h: h}

  image_loaded: =>
    @loaded = true

    width = @img.width
    height = @img.height

    new_wh = @get_resize_dimensions width, height
    @img.width = new_wh.w
    @img.height = new_wh.h

    @show_slide() if @pending_show

  show_slide: () ->
    if not @loaded
      @pending_show = true
      return

    @element.fadeIn("fast")
    @pending_show = false

  hide_slide: () ->
    @element.fadeOut("fast")
