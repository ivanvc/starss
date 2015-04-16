SyncedCron.add
  name: 'Fetch, sync and parse feeds'
  schedule: (parser) -> parser.text('every 1 minutes')
  job: FeedFetcher.fetchAll
