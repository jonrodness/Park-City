function fbinit() {
  var bindFacebookEvents, fb_events_bound, fb_root, initializeFacebookSDK, loadFacebookSDK, restoreFacebookRoot, saveFacebookRoot;

  fb_root = null;

  fb_events_bound = false;

  $(function() {
    loadFacebookSDK();
    if (!fb_events_bound) {
      return bindFacebookEvents();
    }
  });

  bindFacebookEvents = function() {
    $(document).on('page:fetch', saveFacebookRoot).on('page:change', restoreFacebookRoot).on('page:load', function() {
      return typeof FB !== "undefined" && FB !== null ? FB.XFBML.parse() : void 0;
    });
    return fb_events_bound = true;
  };

  saveFacebookRoot = function() {
    return fb_root = $('#fb-root').detach();
  };

  restoreFacebookRoot = function() {
    if ($('#fb-root').length > 0) {
      return $('#fb-root').replaceWith(fb_root);
    } else {
      return $('body').append(fb_root);
    }
  };

  loadFacebookSDK = function() {
    window.fbAsyncInit = initializeFacebookSDK;
    return $.getScript("//connect.facebook.net/en_US/all.js#xfbml=1");
  };

  initializeFacebookSDK = function() {
    return FB.init({
      appId: '1588657804682959',
      // remember to change when uploading to heroku
      channelUrl: 'https://localhost:3000',
      status: true,
      cookie: true,
      xfbml: true
    });
  };
}