Router.configure
  layoutTemplate: 'layout'

Router.route '/feeds',
  name: 'feedsList'
  waitOn: -> Meteor.subscribe('feeds')

Router.route '/feeds/new',
  name: 'feedSubmit'
