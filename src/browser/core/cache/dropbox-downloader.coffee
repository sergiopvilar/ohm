EventEmitter = require("events").EventEmitter
_ = require 'underscore'
dropbox = require '../auth.js'
fs = require 'fs'
utils = require '../utils.js'

class DropboxDownloader
  _.extend @prototype, EventEmitter.prototype

  constructor: (path, location) ->
    that = this
    dropbox.client.readFile path, { arrayBuffer: true }, (error, data) ->

      if error
        that.emit 'error', error
      else
        buffer = utils.toBuffer data
        fs.writeFile location, buffer, ->
          that.emit 'success'

module.exports = DropboxDownloader
