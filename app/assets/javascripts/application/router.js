App.Router.map(function() {
  this.resource('bracket');
  this.resource('leaderboard', function() {
    this.route('you', { path: '/' });
    this.route('friends');
    this.route('top');
  });
  this.resource('prizes');
});