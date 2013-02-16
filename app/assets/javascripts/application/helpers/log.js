App.helpers.log = function(msg) {
  if (typeof(console) == "undefined") return;
  console.log(msg);
};