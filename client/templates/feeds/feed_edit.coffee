Template.feedEdit.events
  'submit form': (e) ->
    e.preventDefault()

    attributes =
      url: $(e.target).find('[name=url]').val()
      name: $(e.target).find('[name=name]').val()
    delete(attributes.url) if attributes.url is @url
    delete(attributes.name) if attributes.name is @name

    Meteor.call 'feedUpdate', @_id, attributes, (error, result) ->
      # TODO: Handle error
      Router.go 'feedsList'
