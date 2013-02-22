Ember.Handlebars.registerBoundHelper('upcase', function(str) {
  return str ? str.toUpperCase() : str;
});