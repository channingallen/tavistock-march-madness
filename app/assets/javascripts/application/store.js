MarchMadness.RESTAdapter = DS.RESTAdapter.extend({
  namespace: 'api'
});

MarchMadness.Store = DS.Store.extend({
  revision: 11,
  adapter: 'MarchMadness.RESTAdapter'
});

