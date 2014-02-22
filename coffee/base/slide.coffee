BiggerPicture = BiggerPicture or {}

class BiggerPicture.Slide

  pending_show: null
  loaded: false

  lw: -1
  lh: -1

  constructor: (image) ->
    {@src, @caption, @id} = image
    @create_image()

  get_resize_dimensions: (w,h,tw,th) ->
    if tw > w or th > h
      scale = if tw/w < th/h then tw/w else th/h
      {
        w: Math.floor(w * scale)
        h: Math.floor(h * scale)
      }
    else
      {w: w, h: h}

  create_image: ->
    @img = new Image()
    @img.onload = (evt) => @image_loaded()
    @img.src = @src

  image_loaded: ->
    @loaded = true

    @width = @img.width
    @height = @img.height

    @show_slide(@pending_show.h, @pending_show.w) if @pending_show

  show_slide: (h, w) ->
    if not @loaded
      @pending_show = { h: h, w: w }
    else
      if not @element or @lh isnt h or @lw isnt w
        @build_element(h, w)
      @element.fadeIn("fast")

  hide_slide: () ->
    @element.fadeOut("fast")

  build_element: (h, w) ->
    @element = $("##{@id}") if not @element
    @lh = h
    @lw = w
    new_wh = @get_resize_dimensions(@width, @height, @lw, @lh)
    @img = $("<img />", {src: @src, width: new_wh.w, height: new_wh.h})
    @element.html(@img)
