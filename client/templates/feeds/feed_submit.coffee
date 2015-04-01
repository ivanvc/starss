Template.feedSubmit.events
  'submit form': (e) ->
    e.preventDefault()

    feed   = url: $(e.target).find('[name=url]').val()
    errors = {}
    unless feed.url
      errors.url = TAPi18n.__('feed_errors_missing_url')
      return Session.set('feedSubmitErrors', errors)

    Meteor.call 'feedInsert', feed, (error, result) ->
      # TODO: Handle error
      Router.go 'feedsList'
