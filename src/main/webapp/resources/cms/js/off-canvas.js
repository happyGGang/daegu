(function($) {
  'use strict';
  $(function() {
    $('[data-toggle="offcanvas"]').on("click", function() {
      $('.sidebar-offcanvas').toggleClass('active')
    });
  });
})(jQuery);

 $(window).resize(function(){
        if( $(window).width() < 1000 ) {
            
            $('.sidebar-offcanvas').addClass('active');
  
        }
    })
