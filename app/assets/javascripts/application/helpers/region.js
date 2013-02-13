Ember.Handlebars.registerBoundHelper('region', function(games) {
  var gamesArr = games.toArray(),
    roundTwoGames = gamesArr.slice(0, 8),
    roundThreeGames = gamesArr.slice(8, 12),
    roundFourGames = gamesArr.slice(12, 14),
    roundFiveGames = gamesArr.slice(14, 15),
    rounds = [],
    teamOne,
    teamTwo;

  // Build round 2.
  var roundTwoHtml = '<section class="round round_2">';
  _.each(roundTwoGames, function(game) {
    roundTwoHtml += App.helpers.gameHtml(game);
  });
  roundTwoHtml += '</section>';

  // Build round 3.
  var roundThreeHtml = '<section class="round round_3">';
  _.each(roundThreeGames, function(game) {
    roundThreeHtml += App.helpers.gameHtml(game);
  });
  roundThreeHtml += '</section>';

  // Build round 4.
  var roundFourHtml = '<section class="round round_4">';
  _.each(roundFourGames, function(game) {
    roundFourHtml += App.helpers.gameHtml(game);
  });
  roundFourHtml += '</section>';
  
  // Build round 5.
  var roundFiveHtml = '<section class="round round_5">';
  _.each(roundFiveGames, function(game) {
    roundFiveHtml += App.helpers.gameHtml(game);
  });
  roundFiveHtml += '</section>';

  // Combine all the rounds.
  var html = [
    roundTwoHtml,
    roundThreeHtml,
    roundFourHtml,
    roundFiveHtml,
    '<div class="clearboth"></div>'
  ].join('');
  return new Handlebars.SafeString(html);
}, 'games');