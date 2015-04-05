Package.describe({
  name: 'stringert-feed-fetcher',
  version: '1.0.0',
  summary: 'A module for automatic RSS/Atom feed discovery.'
});

Npm.depends({
  feedparser: '1.0.0'
});

Package.on_use(function(api) {
  api.use(['coffeescript', 'http', 'percolate:synced-cron'], 'server');
  api.add_files(
    ['feed_fetcher.coffee', 'cron.coffee', 'global_variables.js'],
    'server'
  );
  api.export('FeedFetcher');
});
