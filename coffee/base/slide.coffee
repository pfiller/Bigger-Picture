window.BiggerPicture or= {}

class BiggerPicture.Slide

  constructor: (@image, @container) ->
    @img = new Image()
    @img.addEventListener "load", @image_loaded
    @img.style.display = "none"
    @img.src = @image.src

    @container.append(@img)

  set_image_size_for_display: () ->
    container_height = @container.height() - 75
    container_width = @container.width() * .85

    height_scale = if @raw_image_height > container_height then container_height / @raw_image_height else 1
    width_scale = if @raw_image_width > container_width then container_width / @raw_image_width else 1

    scale = if height_scale < width_scale then height_scale else width_scale

    @img.width = Math.floor(@raw_image_width * scale)
    @img.height = Math.floor(@raw_image_height * scale)

  image_loaded: =>
    @img.style.display = ""
    @raw_image_height = @img.height
    @raw_image_width = @img.width

    @loaded = true
    @show_slide() if @pending_show

  update_position: (new_index) ->
    switch @image.index
      when new_index then @show_slide()
      when new_index + 1 then @set_as_right_thumbnail()
      when new_index - 1 then @set_as_left_thumbnail()
      else @hide_slide()

  show_slide: () ->
    if not @loaded
      @pending_show = true
      return

    @set_image_size_for_display()

    @img.classList.remove('bigger-picture-feature', 'bigger-picture-thumb', 'bigger-picture-right-thumb', 'bigger-picture-left-thumb', 'bigger-picture-hidden')
    @img.classList.add('bigger-picture-feature')

    @pending_show = false

  set_as_right_thumbnail: () ->
    @img.classList.add('bigger-picture-thumb','bigger-picture-right-thumb')
    @img.classList.remove('bigger-picture-feature', 'bigger-picture-left-thumb', 'bigger-picture-hidden')

  set_as_left_thumbnail: () ->
    @img.classList.add('bigger-picture-thumb','bigger-picture-left-thumb')
    @img.classList.remove('bigger-picture-feature', 'bigger-picture-right-thumb', 'bigger-picture-hidden')

  hide_slide: () ->
    @img.classList.add('bigger-picture-hidden')
    @img.classList.remove('bigger-picture-feature', 'bigger-picture-thumb', 'bigger-picture-right-thumb', 'bigger-picture-left-thumb')
