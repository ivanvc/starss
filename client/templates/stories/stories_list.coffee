Template.storiesList.onRendered ->
  getCurrentStory = ->
    $(".story#{window.location.hash}").first()

  key 'j', 'storiesList', ->
    return unless $('.story').length
    hash = window.location.hash
    $nextStory = hash and $(".story#{hash} ~ .story").first()
    $nextStory = $('.story').first() unless $nextStory.length
    StoryItem.showStory $nextStory

  key 'k', 'storiesList', ->
    return unless $('.story').length
    hash = window.location.hash
    $previousStory = $(".story#{hash}").prev()
    $previousStory = $('.story').last() unless $previousStory.length
    StoryItem.showStory $previousStory

  key 'esc', 'storiesList', ->
    $story = getCurrentStory()
    return unless $story
    StoryItem.hideStory $story

  key 'v', 'storiesList', ->
    $story = getCurrentStory()
    return unless $story
    window.open $story.find('.story-link').prop('href'), '_blank'

  key.setScope 'storiesList'
