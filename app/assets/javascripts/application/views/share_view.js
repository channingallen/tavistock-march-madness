App.ShareView = Ember.View.extend({
  elementId: 'share_buttons',
  templateName: 'share',

  // attribute bindings

  shareLink: function() {
    return App.get('pageAppUrl');
  }.property('App.pageAppUrl'),

  tweetText: function() {
    return 'Take the ' + App.get('currentUser.restaurant.name') +
           ' #BracketChallenge for a chance to win!';
  }.property('App.pageAppUrl'),

  mailtoHref: function() {
    var restaurantName = App.get('currentUser.restaurant.name'),
      url = App.get('pageAppUrl');
    return 'mailto:?subject=Take the ' + restaurantName + ' Bracket Challenge' +
           '&body=Join me in taking the ' + restaurantName + ' Bracket ' +
           'Challenge for a chance to win an all-expenses paid trip to Las ' +
           'Vegas, a party for you and five friends, and dining rewards ' +
           'cards at ' + restaurantName + '! Get your brackets in between ' +
           'March 17-20!';
  }.property('App.currentUser', 'App.pageAppUrl'),

  // actions

  shareOnWall: function() {
    App.helpers.facebook.shareOnWall();
  }
});