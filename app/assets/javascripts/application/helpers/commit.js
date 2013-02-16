App.helpers.commitTimeout = null;

App.helpers.commitSent = true;

App.helpers.commit = function(timeout) {
  timeoutMs = timeout || 1500;

  clearTimeout(App.helpers.commitTimeout);
  App.helpers.commitSent = false;
  App.helpers.commitTimeout = setTimeout(function() {
    App.helpers.commitSent = true;
    App.store.commit();
  }, timeoutMs);
}
