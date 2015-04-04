Cheerio = Npm.require('cheerio')

FEED_SELECTORS = [
  'link[type*=rss]'
  'link[type*=atom]'
  'a:contains(RSS)'
  'a[href*=feedburner]'
]

fetch = (url) ->
  response = HTTP.get(url)
  unless response.statusCode is 200
    return error: 'http', statusCode: response.statusCode

  $ = Cheerio.load(response.content)
  if response.headers['content-type'].match('text/xml') and $('rss').length
    return processRSS(url, $)
  processHTML $

processHTML = ($) ->
  selectors = FEED_SELECTORS.reduce (a, b) -> "#{a},#{b}"
  $links    = $(selectors)
  return error: 'no-rss' unless $links.length
  url: $links.first().attr('href'), name: $('title').text(), status: 'good'

processRSS = (url, $) ->
  url: url, name: $('channel > title').text(), status: 'good'

@FeedDiscover =
  fetch: fetch
