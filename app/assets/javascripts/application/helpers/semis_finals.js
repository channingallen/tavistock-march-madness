Ember.Handlebars.registerBoundHelper('semisFinals', function(games) {
  var gamesArr = games.toArray();

  var html = [
    App.helpers.gameHtml(gamesArr[0], ['semi_final']),
    App.helpers.gameHtml(gamesArr[1], ['championship']),
    App.helpers.gameHtml(gamesArr[2], ['semi_final'])
  ].join('');

  return new Handlebars.SafeString(html);
}, 'games');