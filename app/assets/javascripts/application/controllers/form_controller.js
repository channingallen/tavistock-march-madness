App.FormController = Ember.ObjectController.extend({

  branches: function() {
    var restaurant = this.get('content').get('restaurant');
    if (!restaurant.location) return false;

    var restaurants = App.get('restaurants'),
      branches = [],
      thisRestaurant;
    for (var id in restaurants) {
      thisRestaurant = restaurants[id];
      if (restaurant.name == thisRestaurant.name) {
        if (restaurant.id == thisRestaurant.id) {
          thisRestaurant = _.clone(thisRestaurant);
          thisRestaurant.selected = true;
        }
        branches.push(thisRestaurant);
      }
    }
    return branches;
  }.property('content.restaurantId'),

  submitForm: function() {

    // Validate fields.

    var $form = $('#form'),
      firstName = $form.find('#first_name').val();
    if (!firstName || (firstName.length > 254)) {
      alert('Please enter your first name.');
      return;
    }

    var lastName = $form.find('#last_name').val();
    if (!lastName || (lastName.length > 254)) {
      alert('Please enter your last name.');
      return;
    }

    var user = App.get('currentUser'),
      restaurantId = $form.find('#branch').length ?
                     $form.find('#branch').val() :
                     user.get('restaurantId');
    if (!restaurantId) {
      alert('Please choose a restaurant.');
      return;
    }

    var email = $form.find('#email').val();
    if (!email || (email.length > 254) || (email.indexOf('@') == -1)) {
      alert('Please enter a valid email address.');
      return;
    }

    var confirmEmail = $form.find('#confirm_email').val();
    if (confirmEmail != email) {
      alert('Email addresses do not match.');
      return;
    }

    var phone = $form.find('#phone').val();
    if (!phone || (phone.length > 254)) {
      alert('Please enter your phone number.');
      return;
    }

    // Update the user.
    var name = firstName + ' ' + lastName,
      contactAllowed = $form.find('#contact_allowed').is(':checked');
    user.set('name', name);
    user.set('email', email);
    user.set('phone', phone);
    user.set('restaurantId', restaurantId);
    user.set('contactAllowed', contactAllowed);
    App.store.commit();

    // Go to the index.
    this.transitionTo('index');
  }

});