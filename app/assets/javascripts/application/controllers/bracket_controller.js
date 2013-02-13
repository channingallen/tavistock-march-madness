App.BracketController = Ember.ObjectController.extend({
  firstFourGames: function() {
    var games = this.get('content.games'),
      firstFourGames = [];
    return firstFourGames;
  }.property('content.games'),

  buildRegionGames: function(regionNum) {
    var games = this.get('content.games'),
      startingIndex = (regionNum - 1) * 8,
      regionGames = games.toArray().slice(startingIndex, startingIndex + 8),
      nextGame;
    while(regionGames.length < 15) {
      _.each(regionGames, function(game) {
        nextGame = game.get('nextGame');
        if (nextGame && !_.contains(regionGames, nextGame)) {
          regionGames.push(nextGame);
        }
      });
    }
    return regionGames;
  },

  regionOneGames: function() {
    return this.buildRegionGames(1);
  }.property('content.games'),

  regionTwoGames: function() {
    return this.buildRegionGames(2);
  }.property('content.games'),

  regionThreeGames: function() {
    return this.buildRegionGames(3);
  }.property('content.games'),

  regionFourGames: function() {
    return this.buildRegionGames(4);
  }.property('content.games'),

  semisFinalsGames: function() {
    var games = this.get('content.games'),
      gamesArr = games.toArray(),
      championship = _.find(gamesArr, function(game) {
        return (!game.get('nextGame'));
      }),
      semiFinalGames = _.filter(gamesArr, function(game) {
        return (game.get('nextGame') == championship);
      });
    return [semiFinalGames[0], championship, semiFinalGames[1]];
  }.property('content.games'),

  championshipGame: function() {
    var games = this.get('content.games');
    return ;
  }.property('content.games')
});