App.NavigationView = Ember.View.extend({
  elementId: 'navigation',
  tagName: 'nav',
  templateName: 'navigation',

  currentUser: function() {
    return App.get('currentUser');
  }.property('App.currentUser')
});