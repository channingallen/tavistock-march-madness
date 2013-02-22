App.FormController = Ember.ObjectController.extend({

  locations: function() {
    var restaurant = this.get('content').get('restaurant');
    console.log(restaurant);
    if (!restaurant.locations) return false;

    var user = App.get('currentUser'),
      locations = [],
      thisLocation; // remember to avoid using window.location
    for (var i = 0; i < restaurant.locations.length; i++) {
      thisLocation = { name: restaurant.locations[i] };
      if (restaurant.locations[i] == user.get('restaurantLocation')) {
        thisLocation.selected = true;
      }
      locations.push(thisLocation);
    }
    return locations;
  }.property('content.restaurantLocation'),

  submitForm: function() {

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