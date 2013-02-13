App.helpers.gameHtml = function(game, extraClasses) {
  var classes = ['game'];
  extraClasses = extraClasses || [];
  classes = _.uniq(classes.concat(extraClasses));
  classes = classes.join(' ');

  var teamOneName = game.get('teamOne.name'),
    teamOneName = App.helpers.abbreviateTeamName(teamOneName),
    teamTwoName = game.get('teamTwo.name'),
    teamTwoName = App.helpers.abbreviateTeamName(teamTwoName);

  return [
    '<div class="', classes, '" data-game-id="', game.get('id'), '">',
      '<ol>',
        '<li class="team_one">', (teamOneName ? teamOneName : '...'), '</li>',
        '<li class="team_two">', (teamTwoName ? teamTwoName : '...'), '</li>',
      '</ol>',
    '</div>'
  ].join('');
};

App.helpers.abbreviateTeamName = function(teamName) {
  if (!teamName) return '';

  return teamName
    .replace(/^University\sof /, '')
    .replace(/\sUniversity$/, '');
};