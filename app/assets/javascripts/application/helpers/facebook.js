App.helpers.facebook = {

  permissions: {},

  getLoginStatus: function() {
    FB.getLoginStatus(function(response) {
      if (response.status === 'connected') {
        // response.authResponse will look like this:
        // { accessToken: '...',
        //   expiresIn: 5535,
        //   signedRequest: '...',
        //   userID: '707419' }
        // the user's ID, a valid access token, a signed
        // request, and the time the access token
        // and signed request each expire
        App.helpers.log('Authorized!'); // TODO: remove this line
        App.helpers.log(response); // TODO: remove this line
        window.authResponse = response.authResponse; // TODO: remove this line
        var uid = response.authResponse.userID,
          accessToken = response.authResponse.accessToken;
      } else if (response.status === 'not_authorized') {
        // TODO: Ask the user to authenticate our app (he's already logged into FB)
        App.helpers.log('Logged in but not authorized!'); // TODO: remove this line
      } else {
        // TODO: Ask the user to login to FB and authenticate our app if necessary (he's not logged in)
        App.helpers.log('Not logged in!'); // TODO: remove this line
      }
    });
  },

  login: function() {
    FB.login(function(response) {
      window.loginResponse = response; // TODO: remove this line
      if (response.authResponse) {
        App.helpers.log('FB: User logged in. Fetching information...'); // TODO: remove this line
        FB.api('/me', function(response) {
          App.helpers.log('FB: Information fetched for ' + response.name + '.'); // TODO: remove this line
          window.infoResponse = response; // TODO: remove this line
        });
      } else {
        App.helpers.log('FB: User canceled login or did not fully authorize.'); // TODO: remove this line
      }
    }, { scope: '' });
  }
};