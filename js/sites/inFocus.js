// Generated by CoffeeScript 1.6.3
(function() {
  var inFocus;

  inFocus = (function() {
    function inFocus() {
      var container, containers, image_el, images, _i, _len;
      containers = $(".if1280 .ifWrp");
      images = [];
      for (_i = 0, _len = containers.length; _i < _len; _i++) {
        container = containers[_i];
        container = $(container);
        image_el = container.find("img").first();
        images.push({
          image_el: image_el,
          src: image_el.attr('src'),
          caption: container.find(".imgCap").remove("a").text()
        });
      }
      new BiggerPicture.Gallery(images);
    }

    return inFocus;

  })();

  new inFocus();

}).call(this);
