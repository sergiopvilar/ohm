
EventEmitter = require("events").EventEmitter
_ = require 'underscore'
request = require 'request'

class LastFmCoverDriver
  _.extend @prototype, EventEmitter.prototype

  api_key = '87ee4ef93b838030fd74364921c47b95'
  base_api = 'http://ws.audioscrobbler.com/2.0/?format=json&method=album.getInfo&api_key=' + api_key

  constructor: (artist, album) ->

    request base_api + '&artist=' + artist + '&album=' + album, (error, response, body) =>
      try

        unless response.statusCode == 200 or typeof response.error == 'undefined'
          throw new Error 'Cover not found'

        # Check if large image (174x174) exists
        if response.album.image[2]['#text'] == ''
          throw new Error 'Cover not found'

        @emit 'success', response.album.image[2]['#text']

      catch error
        @emit 'error', error

module.exports = LastFmCoverDriver
