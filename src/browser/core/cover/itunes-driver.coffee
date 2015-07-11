
EventEmitter = require("events").EventEmitter
_ = require 'underscore'
request = require 'request'

class ItunesCoverDriver
  _.extend @prototype, EventEmitter.prototype

  base_api = 'https://itunes.apple.com/search?term='

  constructor: (artist, album) ->
    that = this
    request base_api + artist+ ' '+ album, (error, response, body) ->
      try

        unless response.statusCode == 200
          throw new Error 'Cover not found'

        obj = JSON.parse body

        if obj.resultCount == 0
          throw new Error 'Cover not found'

        that.emit 'success', obj.results[0].artworkUrl100

      catch error
        that.emit 'error', error

module.exports = ItunesCoverDriver
