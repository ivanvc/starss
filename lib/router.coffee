Router.configure
  layoutTemplate: 'layout'

@StoriesController = RouteController.extend
  template: 'storiesList'
  subscriptions: ->
    @postsSub = Meteor.subscribe 'stories', @findOptions
    null
  stories: ->
    Stories.find @findOptions(), sort: @sort
  data: ->
    stories: @stories()
    ready: @postsSub.ready

@NewStoriesController = @StoriesController.extend
  findOptions: ->
    { $or: [{ readAt: null }, { readAt: { $gt: new Date() } }] }
  sort:
    pubDate: 1

@StarredStoriesController = @StoriesController.extend
  findOptions: ->
    favedAt: { $not: null }
  sort:
    favedAt: 1

Router.route '/',
  name: 'home'
  controller: @NewStoriesController

Router.route '/starred',
  name: 'starredStories'

Router.route '/feeds',
  name: 'feedsList'
  waitOn: -> Meteor.subscribe('feeds')

Router.route '/feeds/new',
  name: 'feedSubmit'

Router.route '/feeds/:_id/edit',
  name: 'feedEdit'
  waitOn: -> Meteor.subscribe('singleFeed', @params._id)
  data: -> Feeds.findOne(@params._id)
