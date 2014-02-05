(function() {
  require.config({
    paths: {
      jquery: '../../vendor/bower/jquery/jquery'
    },
    include: ['main'],
    insertRequire: ['main'],
    baseUrl: './',
    optimize: 'none',
    wrap: true
  });

}).call(this);
