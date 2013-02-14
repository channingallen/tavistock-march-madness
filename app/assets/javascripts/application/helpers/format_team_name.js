Ember.Handlebars.registerBoundHelper('formatTeamName', function(team) {
  if (!team) return '...';

  return team.get('name')
    .replace(/^University\sof /, '')
    .replace(/\sUniversity$/, '');
});