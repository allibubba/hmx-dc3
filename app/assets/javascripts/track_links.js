function trackLinks() {
  $('.tabs-rym').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'Record Your Moves'])});
  $('.order_copy').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'Order Copy'])});
  $('.dc_com').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'Dance Central Website'])});
  $('.learn-more').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'Learn More'])});
  $('.learn-more-info').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'Learn More Smartglass'])});
  $('.rules_link').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'Rules'])});
  $('.faq_link').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'FAQ'])});
  $('.privacy_link').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'Privacy'])});
  $('.terms_link').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'Terms'])});
  $('.harmonix-icon').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'Harmonix'])});
  $('.xbox-icon').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'Xbox'])});
  $('.xboxlive-icon').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'Live'])});
  $('.kinect-icon').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'Kinect'])});
  $('.sg-icon').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'Smart Glass'])});
  $('.etw-cta a').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'Enter To Win Big'])});
  $('.usher-cta a').click(function(){_gaq.push(['_trackEvent', 'CTA\'s', 'Watch It Now'])});
}

$(trackLinks);