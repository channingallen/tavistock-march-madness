App.BracketController = Ember.ObjectController.extend({

  /**
   * Properties for retrieving subsets of the bracket's games.
   */

  gamesLoaded: function() {
    return this.get('content.games').get('isLoaded');
  }.property('content.games.isLoaded'),

  regionOneRounds: function() {
    return this.buildRegionRounds(this.buildRegionGames(1));
  }.property('content.games.@each'),

  regionTwoRounds: function() {
    return this.buildRegionRounds(this.buildRegionGames(2));
  }.property('content.games.@each'),

  regionThreeRounds: function() {
    return this.buildRegionRounds(this.buildRegionGames(3));
  }.property('content.games.@each'),

  regionFourRounds: function() {
    return this.buildRegionRounds(this.buildRegionGames(4));
  }.property('content.games.@each'),

  semisFinalsGames: function() {
    var games = this.get('content.games');
    if (!games.get('isLoaded')) return [];

    var gamesArr = games.toArray(),
      championship = _.find(gamesArr, function(game) {
        return (!game.get('nextGame'));
      }),
      semiFinalGames = _.filter(gamesArr, function(game) {
        return (game.get('nextGame') == championship);
      });
    return [semiFinalGames[0], championship, semiFinalGames[1]];
  }.property('content.games.@each'),

  /**
   * Helpers for the properties above.
   */

  buildRegionGames: function(regionNum) {
    var games = this.get('content.games');
    if (!games.get('isLoaded')) return [];

    var startingIndex = (regionNum - 1) * 8,
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

  buildRegionRounds: function(games) {
    return [
      { class: "round_2", games: games.slice(0, 8) },
      { class: "round_3", games: games.slice(8, 12) },
      { class: "round_4", games: games.slice(12, 14) },
      { class: "round_5", games: games.slice(14, 15) }
    ];
  }
});