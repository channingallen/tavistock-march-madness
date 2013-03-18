App.helpers.facebook = {

  checkLogin: function() {

    // Ensure the user hasn't logged in, he needs to auth.
    var currentUser = App.get('currentUser');
    if (!currentUser) {
      App.helpers.facebook.promptForAuthorization();
      return;
    }

    // Otherwise, check for authorization.
    FB.getLoginStatus(function(response) {
      if (response.status != 'connected' || !response.authResponse) {
        App.helpers.facebook.promptForAuthorization();
        return;
      }
      if (!response.authResponse.userID) return;
      if (response.authResponse.userID != currentUser.get('fbId')) return;

      // Update the user in our DB and in our front-end data with the most
      // recent data from the Graph API.
      var accessToken = response.authResponse.accessToken;
      FB.api('/me', function(meResponse) {
        App.helpers.facebook.updateUserFromMeResponse(currentUser, accessToken,
                                                      meResponse);
      });

      // Also, store the user's friend IDs.
      App.helpers.facebook.updateFriends();
    });
  },

  updateUserFromMeResponse: function(user, accessToken, meResponse, callback) {
    user.set('name', meResponse.name);
    user.set('gender', meResponse.gender);
    user.set('timezone', meResponse.timezone);
    user.set('fbUsername', meResponse.username);
    user.set('fbAccessToken', accessToken);
    if (App.get('pageId') && !user.get('restaurantId')) {
      user.set('restaurantId', App.get('pageId'));
    }
    user.on('didUpdate', function() {
      App.set('currentUser', App.User.find(user.get('id')));
      if (callback && typeof callback == 'function') callback();
    });
    App.store.commit();
  },

  updateFriends: function() {
    FB.api('/me/friends?fields=id', function(friendsResponse) {
      App.set('friendIds', []);

      if (!friendsResponse.data || !friendsResponse.data.length) return;

      var friendIds;
      for (var i = 0; i < friendsResponse.data.length; i++) {
        friendIds = App.get('friendIds').concat([friendsResponse.data[i].id]);
        App.set('friendIds', friendIds);
      }
    });
  },

  promptForAuthorization: function(callback) {

    // Prompt the user to authorize our app with permission to access Likes.
    FB.login(function(loginResponse) {

      // If the user authorizes our app...
      if (loginResponse.authResponse) {
        var accessToken = loginResponse.authResponse.accessToken;

        // ...retrieve his basic info from Facebook...
        FB.api('/me', function(meResponse) {

          // Use this info to find an existing account for the user (or to
          // create a new one) and assign it to App.currentUser.
          var existingUserRequest = App.User.find({ fb_id: meResponse.id });
          existingUserRequest.on('didLoad', function() {
            var existingUserDetails = this.get('content')[0];
            if (existingUserDetails) {
              var existingUser = App.User.find(existingUserDetails.id);
              App.helpers.facebook.updateUserFromMeResponse(existingUser,
                                                            accessToken,
                                                            meResponse,
                                                            callback);
            } else {
              var newUser = App.User.createRecord({
                name: meResponse.name,
                email: null,
                gender: meResponse.gender,
                timezone: meResponse.timezone,
                fbUsername: meResponse.username,
                fbAccessToken: accessToken,
                restaurantId: App.get('pageId') ? App.get('pageId') : null,
                fbId: meResponse.id,
                contactAllowed: true
              });
              newUser.on('didCreate', function() {
                App.set('currentUser', this);
                if (callback && typeof callback == 'function') callback();
              });
              App.store.commit();
            }
          });
        });

        // ...and update the user's friends.
        App.helpers.facebook.updateFriends();
      }
    });
  },

  enableAutoResizing: function(time) {
    if (!time) time = 100;
    App.helpers.facebook.autoResizeInterval = setInterval(function() {
      FB.Canvas.setSize({ height: $('body').height() });
    }, 100);
  },

  disableAutoResizing: function() {
    clearTimeout(App.helpers.facebook.autoResizeInterval);
  },

  shareOnWall: function(callback) {
    callback = (typeof callback == 'function') ? callback : function() {};
    var restaurantName = App.get('currentUser.restaurant.name');
    FB.ui({
      method: 'feed',
      redirect_uri: App.get('pageAppUrl'),
      link: App.get('pageAppUrl'),
      picture: 'http://ballerassshit.com/assets/icons/page_icon_tab.png',
      name: restaurantName + ' Bracket Challenge',
      caption: 'Enter for a chance to win!',
      description: 'Fill out a bracket between March 17-20 for a chance to ' +
                   'win an all-expenses paid trip to Las Vegas, a party for ' +
                   'you and five friends, and dining rewards card at ' +
                   restaurantName + '.'
    }, callback);
  }
};
