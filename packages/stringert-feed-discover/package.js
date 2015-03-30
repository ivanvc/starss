Package.describe({
  name: 'stringert-feed-discover',
  version: '1.0.5',
  summary: 'A module for automatic RSS/Atom feed discovery.'
});

Npm.depends({
  'feed-discover': '1.0.5',
  'request': '2.54.0'
});

Package.on_use(function(api) {
  api.use('coffeescript', 'server');
  api.add_files(['feed_discover.coffee', 'global_variables.js'], 'server');
  api.export('FeedDiscover');
});
