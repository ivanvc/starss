Package.describe({
  name: 'starss-feed-discover',
  version: '1.0.0',
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
