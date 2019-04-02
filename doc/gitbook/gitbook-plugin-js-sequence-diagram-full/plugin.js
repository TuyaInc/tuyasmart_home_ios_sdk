/**
  * Copyright (C) 2016 yanni4night.com
  * plugin.js
  *
  * changelog
  * 2016-06-04[02:07:21]:revised
  *
  * @author yanni4night@gmail.com
  * @version 1.0.0
  * @since 1.0.0
  */
require(["jquery", "gitbook"], function($, gitbook) {
  gitbook.events.bind("page.change", function() {
    $('code.lang-sequence').each(function(index, element) {
      var $element = $(element);
      $element.sequenceDiagram({theme: 'simple'});

      var wrapper = $("<div class='scroll'></div>");
      wrapper.html($element.html());
      $element.parent().replaceWith(wrapper);
    });
  });
});
