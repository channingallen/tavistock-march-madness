App.RESTAdapter = DS.RESTAdapter.extend({
  namespace: 'api'
});

App.Store = DS.Store.extend({
  revision: 11,
  adapter: 'App.RESTAdapter'
});

App.set('store', App.Store.create());