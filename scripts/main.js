(function() {
  require(['app', 'jquery'], function(app, $) {
    console.log(app);
    return console.log('Running jQuery %s', $().jquery);
  });

}).call(this);
