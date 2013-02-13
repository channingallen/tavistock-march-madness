App.helpers.gameHtml = function(game, extraClasses) {
  var classes = _.uniq(['game'].concat(extraClasses || [])).join(' '),
    rawTeamOneName = game.get('teamOne.name'),
    rawTeamTwoName = game.get('teamTwo.name'),
    teamOneName = App.helpers.abbreviateTeamName(rawTeamOneName),
    teamTwoName = App.helpers.abbreviateTeamName(rawTeamTwoName),
    score = game.get('score');

  return [
    '<div class="', classes, '" data-game-id="', game.get('id'), '">',
      (score ? '<span class="score">+' + score + '</span>' : ''),
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