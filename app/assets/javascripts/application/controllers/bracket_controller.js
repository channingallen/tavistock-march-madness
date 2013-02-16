App.BracketController = Ember.ObjectController.extend({

  /**
   * Returns true if the games and bracket have finished loading, false
   * otherwise.
   */
  gamesLoaded: function() {
    var bracketLoaded = this.get('content.games').get('isLoaded'),
      gamesLoaded = this.get('content.games').get('isLoaded');
    return (bracketLoaded && gamesLoaded);
  }.property('content.games.@each.isLoaded'),

  /**
   * Selects the team as the winner for its game.
   */
  selectTeam: function(game, team) {
    if (game.get('isLoaded')) {
      if (game.get('winningTeam') == team) {
        game.set('winningTeam', null);
      } else {
        game.set('winningTeam', team);
      }
      game.updateNextGame();
    } else {
      alert('Unable to select to select team. Please wait a moment and try ' +
            'again.');
    }
  },

  /**
   * The following functions retrieve different subsets of the games that make
   * up the bracket.
   */

  regionOneRounds: function() {
    return this.buildRegionRounds(this.buildRegionGames(1));
  }.property('content.games.@each.score',
             'content.games.@each.winningTeam',
             'content.games.@each.teamOne',
             'content.games.@each.teamTwo'),

  regionTwoRounds: function() {
    return this.buildRegionRounds(this.buildRegionGames(2));
  }.property('content.games.@each.score',
             'content.games.@each.winningTeam',
             'content.games.@each.teamOne',
             'content.games.@each.teamTwo'),

  regionThreeRounds: function() {
    return this.buildRegionRounds(this.buildRegionGames(3));
  }.property('content.games.@each.score',
             'content.games.@each.winningTeam',
             'content.games.@each.teamOne',
             'content.games.@each.teamTwo'),

  regionFourRounds: function() {
    return this.buildRegionRounds(this.buildRegionGames(4));
  }.property('content.games.@each.score',
             'content.games.@each.winningTeam',
             'content.games.@each.teamOne',
             'content.games.@each.teamTwo'),

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
  }.property('content.games.@each.score',
             'content.games.@each.winningTeam',
             'content.games.@each.teamOne',
             'content.games.@each.teamTwo'),

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