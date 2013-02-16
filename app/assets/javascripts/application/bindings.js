App.bindings = function() {

  /**
   * If the user attempts to navigate away from the page while model changes are
   * still in the pipeline to be committed, prompt the user to stay and wait.
   */
  window.onbeforeunload = function (e) {
    if (!App.helpers.commitSent) {

      // Send a request to finish saving changes.
      App.helpers.commit(1);

      // Show the user a message.
      e = e || window.event;
      var message = 'We need a second to save changes to your bracket.';
      if (e) e.returnValue = message; // for IE and Firefox
      return message; // for Safari
    }
  };

};