App.BracketController = Ember.ObjectController.extend({

  preparationPhase: function() {
    return App.get('phase') == 'preparation';
  }.property('App.phase'),

  phase: function() {
    return App.get('phase');
  }.property('App.phase'),

  /**
   * Returns true if the games and bracket have finished loading, false
   * otherwise.
   */
  bracketDoneLoading: function() {
    var bracket = this.get('content');
    if (!bracket.get('isLoaded')) return false;

    var gamesLoaded = true;
    this.get('content.games').forEach(function(game) {
      if (!game.get('isLoaded')) gamesLoaded = false;
    });
    return gamesLoaded;
  }.property('content.isLoaded', 'content.games.@each.isLoaded'),

  totalScore: function() {
    var bracket = this.get('content');
    if (bracket.get('isOfficial')) return false;

    var score = 0;
    bracket.get('games').forEach(function(game) {
      score += game.get('score');
    });
    return score;
  }.property('content.games.@each.score'),

  /**
   * Selects the team as the winner for its game.
   */
  selectTeam: function(game, team) {

    // Ensure the game has been loaded.
    if (!game.get('isLoaded')) {
      alert('Unable to select to select team. Please wait a moment and try ' +
            'again.');
      return;
    }

    // Ensure there's actually a team to select.
    if (!team) return;

    // Abide by rules depending on the phase and the bracket type.
    var bracket = this.get('content'),
      phase = App.get('phase');
    switch(phase) {

      // Anything is allowed during the testing phase.
      case 'testing':
        break;

      // No editing of any bracket during the preparation phase.
      case 'preparation':
        return;
        break;

      // No editing of the official bracket during the selection phase.
      case 'selection':
        if (bracket.get('isOfficial')) {
          alert('Changes blocked until the tournament begins');
          return;
        }
        break;

      // No editing your individual bracket during the tournament phase.
      case 'tournament':
        if (!bracket.get('isOfficial')) return;
        break;
    }

    if (game.get('winningTeam') == team) {
      game.set('winningTeam', null);
    } else {
      game.set('winningTeam', team);
    }
    game.updateNextGame();
  },

  /**
   * The following functions retrieve different subsets of the games that make
   * up the bracket.
   */

  firstFourGames: function() {
    var games = this.get('content.games');
    if (!games.get('isLoaded')) return [];

    var gamesArr = games.toArray();
    return [gamesArr[gamesArr.length - 4],
            gamesArr[gamesArr.length - 3],
            gamesArr[gamesArr.length - 2],
            gamesArr[gamesArr.length - 1]];
  }.property('content.games.@each.score',
             'content.games.@each.winningTeam',
             'content.games.@each.teamOne',
             'content.games.@each.teamTwo'),

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