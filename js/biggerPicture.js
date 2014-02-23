// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.BiggerPicture || (window.BiggerPicture = {});

  BiggerPicture.Gallery = (function() {
    Gallery.prototype.slides = [];

    Gallery.prototype.container = $("<div />", {
      "class": "bigger-picture"
    });

    function Gallery(images) {
      this.resize_all_images = __bind(this.resize_all_images, this);
      this.trigger_resize = __bind(this.trigger_resize, this);
      this.test_keypress = __bind(this.test_keypress, this);
      this.nav_left = __bind(this.nav_left, this);
      this.nav_right = __bind(this.nav_right, this);
      var i, image, _i, _len;
      $("body").addClass("bigger-picture-active").append(this.container);
      for (i = _i = 0, _len = images.length; _i < _len; i = ++_i) {
        image = images[i];
        this.set_up_image(image, i);
      }
      this.set_up_listeners();
    }

    Gallery.prototype.remove = function() {
      $("body").removeClass("bigger-picture-active");
      this.container.remove();
      return delete this.slides;
    };

    Gallery.prototype.set_up_image = function(image, i) {
      image.index = i;
      if (image.src) {
        this.slides.push(new BiggerPicture.Slide(image, this.container));
      }
      return this.set_current(0);
    };

    Gallery.prototype.set_current = function(current_index) {
      var slide, _i, _len, _ref;
      this.current_index = current_index;
      _ref = this.slides;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        slide = _ref[_i];
        slide.update_position(this.current_index);
      }
      return window.setTimeout((function() {
        return window.scrollTo(0, 0);
      }), 0);
    };

    Gallery.prototype.set_up_listeners = function() {
      window.onresize = this.trigger_resize;
      $("body").on("keydown", this.test_keypress);
      this.container.on("click", ".bigger-picture-right-thumb", this.nav_right);
      return this.container.on("click", ".bigger-picture-left-thumb", this.nav_left);
    };

    Gallery.prototype.nav_right = function(evt) {
      if (evt != null) {
        evt.preventDefault();
      }
      if (this.current_index < this.slides.length - 1) {
        return this.set_current(this.current_index + 1);
      }
    };

    Gallery.prototype.nav_left = function(evt) {
      if (evt != null) {
        evt.preventDefault();
      }
      if (this.current_index > 0) {
        return this.set_current(this.current_index - 1);
      }
    };

    Gallery.prototype.test_keypress = function(evt) {
      switch (evt.keyCode) {
        case 39:
        case 40:
          return this.nav_right(evt);
        case 37:
        case 38:
          return this.nav_left(evt);
        case 27:
          evt.preventDefault();
          return this.remove();
      }
    };

    Gallery.prototype.trigger_resize = function() {
      this.slides[this.current_index].set_image_size_for_display();
      clearTimeout(this.resize_timeout);
      return this.resize_timeout = setTimeout(this.resize_all_images, 100);
    };

    Gallery.prototype.resize_all_images = function() {
      var slide, _i, _len, _ref, _results;
      _ref = this.slides;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        slide = _ref[_i];
        _results.push(slide.set_image_size_for_display());
      }
      return _results;
    };

    return Gallery;

  })();

  window.BiggerPicture || (window.BiggerPicture = {});

  BiggerPicture.Slide = (function() {
    function Slide(slide, container) {
      this.slide = slide;
      this.container = container;
      this.image_loaded = __bind(this.image_loaded, this);
      this.img = new Image();
      this.img.addEventListener("load", this.image_loaded);
      this.img.style.display = "none";
      this.img.src = this.slide.src;
      this.container.append(this.img);
    }

    Slide.prototype.set_image_size_for_display = function() {
      var container_height, container_width, height_scale, scale, width_scale;
      container_height = this.container.height() * .9;
      container_width = this.container.width() * .85;
      height_scale = this.raw_image_height > container_height ? container_height / this.raw_image_height : 1;
      width_scale = this.raw_image_width > container_width ? container_width / this.raw_image_width : 1;
      scale = height_scale < width_scale ? height_scale : width_scale;
      this.img.width = Math.floor(this.raw_image_width * scale);
      this.img.height = Math.floor(this.raw_image_height * scale);
      if (this.caption) {
        return this.position_caption();
      }
    };

    Slide.prototype.image_loaded = function() {
      this.img.style.display = "";
      this.raw_image_height = this.img.height;
      this.raw_image_width = this.img.width;
      this.set_image_size_for_display();
      this.loaded = true;
      if (this.pending_show) {
        return this.show_slide();
      }
    };

    Slide.prototype.update_position = function(new_index) {
      switch (this.slide.index) {
        case new_index:
          return this.show_slide();
        case new_index + 1:
          return this.set_as_right_thumbnail();
        case new_index - 1:
          return this.set_as_left_thumbnail();
        default:
          return this.hide_slide();
      }
    };

    Slide.prototype.show_slide = function() {
      if (!this.loaded) {
        this.pending_show = true;
        return;
      }
      this.img.className = "";
      this.img.classList.add('bigger-picture-feature');
      if (this.slide.caption) {
        this.add_caption();
      }
      return this.pending_show = false;
    };

    Slide.prototype.add_caption = function() {
      this.caption = document.createElement("div");
      this.caption.className = "bigger-picture-caption";
      this.caption.innerHTML = this.slide.caption;
      this.container.append(this.caption);
      return this.position_caption();
    };

    Slide.prototype.position_caption = function() {
      var image_bound;
      image_bound = this.img.getBoundingClientRect();
      this.caption.style.maxWidth = "" + (Math.round(image_bound.width)) + "px";
      return this.caption.style.top = "" + (image_bound.bottom - this.caption.getBoundingClientRect().height) + "px";
    };

    Slide.prototype.set_as_right_thumbnail = function() {
      var _ref;
      this.img.className = "";
      this.img.classList.add('bigger-picture-thumb', 'bigger-picture-right-thumb');
      return (_ref = this.caption) != null ? _ref.remove() : void 0;
    };

    Slide.prototype.set_as_left_thumbnail = function() {
      var _ref;
      this.img.className = "";
      this.img.classList.add('bigger-picture-thumb', 'bigger-picture-left-thumb');
      return (_ref = this.caption) != null ? _ref.remove() : void 0;
    };

    Slide.prototype.hide_slide = function() {
      var _ref;
      this.img.className = "";
      this.img.classList.add('bigger-picture-hidden');
      return (_ref = this.caption) != null ? _ref.remove() : void 0;
    };

    return Slide;

  })();

}).call(this);
