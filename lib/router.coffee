Router.configure
  layoutTemplate: 'layout'

Router.route '/',
  name: 'storiesList'
  waitOn: -> Meteor.subscribe('stories')

Router.route '/feeds',
  name: 'feedsList'
  waitOn: -> Meteor.subscribe('feeds')

Router.route '/feeds/new',
  name: 'feedSubmit'

Router.route '/feeds/:_id/edit',
  name: 'feedEdit'
  waitOn: -> Meteor.subscribe('singleFeed', @params._id)
  data: -> Feeds.findOne(@params._id)
