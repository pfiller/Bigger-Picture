window.BiggerPicture or= {}

class BiggerPicture.Slide

  container_class: 'bigger-picture-slide'

  constructor: (@slide, @container) ->
    @slide_container = document.createElement("figure")
    @container.append(@slide_container)

    @build_img_tag()

  build_img_tag: () ->
    @img = new Image()
    @img.addEventListener "load", @image_loaded
    @img.style.display = "none"
    @img.src = @slide.src


    @img.style.width = "100%"

    @slide_container.appendChild(@img)

  set_image_size_for_display: () ->
    container_height = @container.height() * .9
    container_width = @container.width() * .85

    height_scale = if @raw_image_height > container_height then container_height / @raw_image_height else 1
    width_scale = if @raw_image_width > container_width then container_width / @raw_image_width else 1

    scale = if height_scale < width_scale then height_scale else width_scale

    @display_width = Math.floor(@raw_image_width * scale)
    @display_height = Math.floor(@raw_image_height * scale)

    @position_caption() if @caption

  image_loaded: =>
    @img.style.display = ""
    @raw_image_height = @img.height
    @raw_image_width = @img.width

    @set_image_size_for_display()

    @loaded = true
    @show_slide() if @pending_show

  update_position: (new_index) ->
    switch @slide.index
      when new_index then @show_slide()
      when new_index + 1 then @set_as_right_thumbnail()
      when new_index - 1 then @set_as_left_thumbnail()
      else @hide_slide()

  show_slide: () ->
    if not @loaded
      @pending_show = true
      return

    @slide_container.className = ""
    @slide_container.classList.add(@container_class, 'bigger-picture-feature')
    @slide_container.style.width = "#{@display_width}px"
    @slide_container.style.height = "#{@display_height}px"

    @caption?.show()

    @pending_show = false


  add_caption: () ->
    @caption = document.createElement("div")
    @caption.className = "bigger-picture-caption"
    @caption.innerHTML = @slide.caption
    @slide_container.appendChild(@caption)
    @position_caption()

  position_caption: () ->
    image_bound = @img.getBoundingClientRect()
    @caption.style.maxWidth = "#{Math.round(image_bound.width)}px"
    @caption.style.top = "#{image_bound.bottom-@caption.getBoundingClientRect().height}px"

  set_as_right_thumbnail: () ->
    @slide_container.style.width = ""
    @slide_container.style.height = ""
    @slide_container.className = ""
    @slide_container.classList.add(@container_class, 'bigger-picture-thumb','bigger-picture-right-thumb')
    @caption?.hide()

  set_as_left_thumbnail: () ->
    @slide_container.style.width = ""
    @slide_container.style.height = ""
    @slide_container.className = ""
    @slide_container.classList.add(@container_class, 'bigger-picture-thumb','bigger-picture-left-thumb')
    @caption?.hide()

  hide_slide: () ->
    @slide_container.style.width = ""
    @slide_container.style.height = ""
    @slide_container.className = ""
    @slide_container.classList.add('bigger-picture-hidden')
