BLACKLISTED_TAGS = ['b', 'i', 'strong', 'em', 'blockquote', 'ol', 'ul', 'li',
                    'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'h7', 'p', 'span',
                    'pre', 'a', 'u', 'img', 'br', 'table']

hideStory = ($target) ->
  window.location.hash = ''
  $target.removeClass('primary current').addClass 'secondary preview'

showStory = ($target, storyId) ->
  window.location.hash = $target.prop('id')
  $('.stories .story').removeClass('primary current').
    addClass 'secondary preview'
  $target.removeClass('secondary preview').addClass 'primary current'
  Meteor.call 'readStory', storyId, (error, result) ->
    console.log(error) if error

Template.storyItem.onRendered ->
  $('.ui.rating', $(@firstNode)).rating
    clearable: true
    onRate: (rate) ->
      Meteor.call 'favStory', @dataset.id, rate, (error, result) ->
        console.log(error) if error
  $('.full-text a', $(@firstNode)).prop 'target', '_blank'

Template.storyItem.helpers
  formattedPubDate: ->
    moment(@pubDate).format 'lll'
  isFaved: ->
    @favedAt && 1 || 0
  previewText: ->
    UniHTML.purify @description,
      withoutTags: BLACKLISTED_TAGS, noFormatting: true

Template.storyItem.events
  'click .story-title': (e) ->
    return if $(e.target).hasClass('icon')
    $target = $(e.currentTarget).parents('.story')
    if $target.hasClass('current')
      hideStory $target
    else
      showStory $target, @_id
