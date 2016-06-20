/**
 * @author Alexander Manzyuk <admsev@gmail.com>
 * Copyright (c) 2012 Alexander Manzyuk - released under MIT License
 * https://github.com/admsev/jquery-play-sound
 * Usage: $.playSound('http://example.org/sound.mp3');
**/

(function($){

  $.extend({
    playSound: function(){
		return $("<audio autoplay='autoplay'><source src='" +arguments[0]+"' /></audio>").appendTo('body');
    }
  });

})(jQuery);
