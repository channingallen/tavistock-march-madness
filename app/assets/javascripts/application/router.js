App.Router.map(function() {
  this.route('form');
  this.route('prizes');
  this.route('rules');
  this.resource('bracket', { path: '/bracket/:bracket_id' });
  this.resource('leaderboard', function() {
    this.route('you', { path: '/' });
    this.route('friends');
    this.route('top');
  });
});