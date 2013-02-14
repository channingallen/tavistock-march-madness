App.Router.map(function() {
  this.resource('bracket', { path: '/bracket/:bracket_id' }, function() {

  });
  this.resource('leaderboard', function() {
    this.route('you', { path: '/' });
    this.route('friends');
    this.route('top');
  });
  this.resource('prizes');
});