// Animations used across the app
$(function(){

  // PC FONT SWAP => DIE PC
  var pc_font_swap;
  pc_font_swap = function() {
    if (navigator.appVersion.indexOf("Win") !== -1) {
      $('.reg').addClass('pc');
      // $('.reg').css('font-family', 'Arial');
    }
  };


  pc_font_swap();


  if ($.browser.mozilla) {
    $('body').addClass('mozilla');
  }

  $('.share-top .t-icon').mouseover(function(){
    TweenLite.to($(this), .5, {css:{autoAlpha:.7}, ease:Expo.easeOut});
  }).mouseout(function(){
    TweenLite.to($(this), .5, {css:{autoAlpha:1}, ease:Expo.easeOut});
  });

  $('.yt-link').mouseover(function(){
    TweenLite.to($(this), .5, {css:{autoAlpha:1}, ease:Expo.easeOut});
  }).mouseout(function(){
    TweenLite.to($(this), .5, {css:{autoAlpha:.7}, ease:Expo.easeOut});
  });

  // Video Navigation Arrows
  $('.vid-nav.left').mouseover(function(){
    TweenLite.to($(this), .5, {css:{autoAlpha: 1}, ease:Expo.easeOut});
    TweenLite.to($(this).find('a'), .5, {css:{left:-3, width: 70, autoAlpha: 1}, ease:Expo.easeOut});
  }).mouseout(function(){
    TweenLite.to($(this).find('a'), .5, {css:{left:2, width: 63, autoAlpha: .7}, ease:Expo.easeOut});
  });
  $('.vid-nav.right').mouseover(function(){
      TweenLite.to($(this), .5, {css:{autoAlpha: 1}, ease:Expo.easeOut});
      TweenLite.to($(this).find('a'), .5, {css:{backgroundPosition: "-160px center", autoAlpha: 1}, ease:Expo.easeOut});
    }).mouseout(function(){
      TweenLite.to($(this).find('a'), .5, {css:{backgroundPosition: "-167px center", autoAlpha: .7}, ease:Expo.easeOut});
    });


  // Video Modals
  $('.usher-cta a').click(function(e){
    e.preventDefault();
    
    $("#vid-modal").modal({
      opacity: 70,
      overlayClose: true,
      minWidth: 815,
      minHeight: 480,
      onOpen: openEffect,
      onClose: closeEffect
    });

    $('.go-back-btn').click(function(e){
      e.preventDefault();
      $('#simplemodal-container').fadeOut('fast', function(){
        $('#simplemodal-overlay').fadeOut('slow', function(){
          $.modal.close(); 
        })
      });
    })

    function closeEffect(dialog) {
      var flashMovie;
      if($('#camRecorder').length > 0){
        flashMovie=getFlashMovieObject("camRecorder");
        flashMovie.asUnmute();
      }

      if($('#dancePlayer').length > 0){
          flashMovie=getFlashMovieObject("dancePlayer");
          flashMovie.asUnmute();
      }

      if($('#thanksTarget').length > 0){
        jwplayer(document.getElementById('thanksTarget')).play();
      }

      if($('#videoPlayerContainer').length > 0  && $('#camRecorder').length < 1 && $('#thanksTarget').length < 1){
        jwplayer(document.getElementById('videoPlayerContainer')).play();
      }
        
      

      dialog.data.fadeOut('slow', function () {
        dialog.container.slideUp('fast', function () {
          dialog.overlay.fadeOut('slow', function () {
            $.modal.close();
          });
        });
      });
    }

    function openEffect(dialog) {
       if($('#camRecorder').length > 0){
        flashMovie=getFlashMovieObject("camRecorder");
        flashMovie.asMute();
      }

      if($('#dancePlayer').length > 0){
          var flashMovie=getFlashMovieObject("dancePlayer");
          flashMovie.asMute();
      }

      if($('#movesPlayer').length > 0){
        //document.getElementById('movesPlayer').setMute(true);
        document.getElementById('movesPlayer').stopVideo();
      }
      if($('#thanksTarget').length > 0){
        jwplayer(document.getElementById('thanksTarget')).stop();
      }
      if($('#videoPlayerContainer').length > 0 && $('#camRecorder').length < 1 && $('#thanksTarget').length < 1){
        jwplayer(document.getElementById('videoPlayerContainer')).stop();
      }
      

      dialog.overlay.fadeIn('slow', function () {
        dialog.container.slideDown('fast', function () {
          dialog.data.fadeIn('slow');
        });
      });
    }

    // set cookie to be sure video doesn't pop back up
    //$.cookie('playintro','viewed');
    console.log('was called');

    function getFlashMovieObject(movieName){
      if (window.document[movieName]){
        return window.document[movieName];
      }
      if (navigator.appName.indexOf("Microsoft Internet")==-1){
        if (document.embeds && document.embeds[movieName])
          return document.embeds[movieName];
      }
      else{
        return document.getElementById(movieName);
      }  
    }  

  });


  // User Blocks
  $("#user-block .user-block:odd").addClass('user-block-right');
  $("#user-block .user-block:even").addClass('user-block-left');



  // Tabs
  $("ul.tabs").tabs("div.panes > div");

  $('.img-overlay').hide();
  $('.imhover').mouseover(function(){
    $(this).find('.img-overlay').show();

  }).mouseout(function(){
    $(this).find('.img-overlay').hide();
  });

  // Language Select Drop Down

  // $('.lang-select').ddslick({
  //   defaultSelectedIndex: 4,
  //   background: 'transparent',
  //   width: '75px',
  //   onSelected: function (data) {
  //     var locale = $('html').attr('id');
  //     var lang = data.selectedData.value;

  //     console.log('the html tag is ' + locale);

  //     switch (lang) { 
  //         case 'en_US': 
  //             if (locale == 'en_US') {
  //               return false;
  //             } else {
  //               window.location = '/home/locale/'+lang;
  //             }
  //             break;
  //         case 'en_GB': 
  //             if (locale == 'en_GB') {
  //               return false;
  //             } else {
  //               window.location = '/home/locale/'+lang;
  //             }
  //             break;
  //         case 'en_MX': 
  //             if (locale == 'en_MX') {
  //               return false;
  //             } else {
  //               window.location = '/home/locale/'+lang;
  //             }
  //             break;        
  //         case 'en_FR': 
  //             if (locale == 'en_FR') {
  //               return false;
  //             } else {
  //               window.location = '/home/locale/'+lang;
  //             }
  //             break;
  //         default:
  //             console.log('en_US Wins!');
  //     }
  //   }

    

  // });

  // language selection 
  $('.lang-select').dropkick({
    change: function (value, label) {
      //console.log(value, label);
      window.location = '/home/locale/'+value;
    }
  });

  var dk_label = $('.dk_option_current a').data('dk-dropdown-value');
  var locale = $('html').attr('id');

  if (locale == 'en_US' ) {
    $('.dk_label').text('English');
  }

  if (locale == 'en_GB' ) {
    $('.dk_label').text('British');
  }


  $(document).click(function(){
    $('.dk_open').removeClass('dk_open');
  });

  $('.dk_open').live('click',function(e){
    e.stopPropagation();
  });


  $('.load-down').click(function(e){
    e.preventDefault();
  });
  $('.load-up').click(function(e){
    e.preventDefault();
  });



  // File input
  $("input:file").uniform();

  // Vertical Scroll for Tab video items
  $('.scrollable').each(function(){
    $(this).scrollable({ vertical: true });
    
  });



});

  

// check if intro video has played
$(document).ready(function() {
  console.log('>>>', $.cookie('playintro'));

  if(window.location.href.indexOf("vid") > -1) {
    // do not show intro
  }else{
    if($.cookie('playintro') == 'viewed'){
      //console.log('already viewed')
      return false;
    }else{
      console.log('not viewed', $('usher-cta a'))
      $('.usher-cta a').trigger("click");
      $.cookie('playintro','viewed');
      
    }
  }
});
