//= require external/jquery-1.9.1.min
//= require external/underscore
//= require handlebars
//= require ember
//= require ember-data

// Before including Ember files, set up the namespace.
//= require ./application/setup

// Before we set up application files, set up the application.
//= require ./application/store
//= require ./application/router
//= require ./application/bindings

// Set up application files.
//= require_tree ./application/routes
//= require_tree ./application/models
//= require_tree ./application/controllers
//= require_tree ./application/views
//= require_tree ./application/helpers
//= require_tree ./application/templates