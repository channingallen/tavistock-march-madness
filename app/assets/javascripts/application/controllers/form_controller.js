App.FormController = Ember.ObjectController.extend({

  tournamentPhase: function() {
    return App.get('phase') == 'tournament';
  }.property('App.phase'),

  locations: function() {
    var user = this.get('content');

    var restaurant = user ?
                     user.get('restaurant') :
                     App.get('restaurants')[App.get('pageId')];
    if (!restaurant.locations) return false;

    var locations = [],
      thisLocation; // remember to avoid using window.location
    for (var i = 0; i < restaurant.locations.length; i++) {
      thisLocation = { name: restaurant.locations[i] };
      if (user && restaurant.locations[i] == user.get('restaurantLocation')) {
        thisLocation.selected = true;
      } else if (i == 0) {
        thisLocation.selected = true;
      }
      locations.push(thisLocation);
    }
    return locations;
  }.property('content.restaurantLocation'),

  restaurant: function() {
    if (this.get('content')) {
      return this.get('content').get('restaurant');
    } else {
      return App.get('restaurants')[App.get('pageId')];
    }
  }.property('content.restaurantId'),

  submitForm: function() {

    // Ensure the user has authenticated.
    if (!App.get('currentUser')) {
      App.helpers.facebook.promptForAuthorization(this.submitForm);
      return;
    }

    // Validate fields.

    var $form = $('#form'),
      firstName = $form.find('#first_name').val();
    if (!firstName || (firstName.length > 254)) {
      alert('Please enter your first name.');
      return false
    }

    var lastName = $form.find('#last_name').val();
    if (!lastName || (lastName.length > 254)) {
      alert('Please enter your last name.');
      return false
    }

    var email = $form.find('#email').val();
    if (!email || (email.length > 254) || (email.indexOf('@') == -1)) {
      alert('Please enter a valid email address.');
      return false
    }

    var confirmEmail = $form.find('#confirm_email').val();
    if (confirmEmail != email) {
      alert('Email addresses do not match.');
      return false
    }

    var phone = $form.find('#phone').val();
    if (!phone || (phone.length > 254)) {
      alert('Please enter your phone number.');
      return false;
    }

    // Update the user.
    var user = App.get('currentUser'),
      name = firstName + ' ' + lastName,
      contactAllowed = $form.find('#contact_allowed').is(':checked'),
      location = $form.find('#location').length ? $form.find('#location').val() : '';
    user.set('name', name);
    user.set('email', email);
    user.set('phone', phone);
    user.set('restaurantLocation', location);
    user.set('contactAllowed', contactAllowed);
    App.store.commit();

    // Go to the index.
    this.transitionTo('index');
    return false;
  }

});
