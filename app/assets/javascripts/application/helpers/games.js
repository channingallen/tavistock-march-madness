App.helpers.gameHtml = function(game, extraClasses) {
  var classes = _.uniq(['game'].concat(extraClasses || [])).join(' '),
    teamOne = game.get('teamOne'),
    teamTwo = game.get('teamTwo'),
    winningTeam = game.get('winningTeam'),
    rawTeamOneName = teamOne ? teamOne.get('name') : '',
    rawTeamTwoName = teamTwo ? teamTwo.get('name') : '',
    teamOneName = App.helpers.abbreviateTeamName(rawTeamOneName),
    teamTwoName = App.helpers.abbreviateTeamName(rawTeamTwoName);

  // Set up classes for team one ("team_one", "chosen", and/or "winner").
  var teamOneClasses = ['team_one'];
  if (teamOne) teamOneClasses.push('chosen');
  if (winningTeam && winningTeam == teamOne) teamOneClasses.push('winner');
  teamOneClasses = teamOneClasses.join(' ');

  // Set up classes for team two ("team_two", "chosen", and/or "winner").
  var teamTwoClasses = ['team_two'];
  if (teamTwo) teamTwoClasses.push('chosen');
  if (winningTeam && winningTeam == teamTwo) teamTwoClasses.push('winner');
  teamTwoClasses = teamTwoClasses.join(' ');

  // Mark games that the user still needs to attend to.
  var roundNumber = game.get('roundNumber'),
    todoRound2 = (roundNumber == 2 && (!teamOne || !teamTwo || !winningTeam)),
    todoRound3Plus = (roundNumber > 2 && !winningTeam && teamOne && teamTwo);
  if (todoRound2 || todoRound3Plus) classes += ' todo';

  // Mark games that the user correctly predicted.
  var score = game.get('score');
  if (score > 0) classes += ' points_awarded';

  return [
    '<div class="', classes, '" data-game-id="', game.get('id'), '">',
      '<span class="score">+' + score + '</span>',
      '<ol>',
        '<li class="', teamOneClasses, '">',
          (teamOneName ? teamOneName : '...'),
        '</li>',
        '<li class="', teamTwoClasses, '">',
          (teamTwoName ? teamTwoName : '...'),
        '</li>',
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