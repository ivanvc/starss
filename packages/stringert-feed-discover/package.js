Package.describe({
  name: 'stringert-feed-discover',
  version: '1.0.5',
  summary: 'A module for automatic RSS/Atom feed discovery.'
});

Npm.depends({
  cheerio: '0.19.0'
});

Package.on_use(function(api) {
  api.use(['coffeescript', 'http'], 'server');
  api.add_files(['feed_discover.coffee', 'global_variables.js'], 'server');
  api.export('FeedDiscover');
});
