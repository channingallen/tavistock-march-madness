App.ShareView = Ember.View.extend({
  elementId: 'share_buttons',
  templateName: 'share',

  // attribute bindings

  shareLink: function() {
    return App.get('pageAppUrl');
  }.property('App.pageAppUrl'),

  mailtoHref: function() {
    return 'mailto:?subject=March Madness Bracket&body=Join me in ' +
        'filling out a bracket for ' + App.get('currentUser.restaurant.name') +
        '\'s March Madness Bracket Challenge! ' + App.get('pageAppUrl');
  }.property('App.currentUser', 'App.pageAppUrl'),

  // actions

  shareOnWall: function() {
    App.helpers.facebook.shareOnWall();
  }
});