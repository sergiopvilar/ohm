dropbox = require('./auth')
config = require '../models/config'

class DropboxDriver

  that = null

  constructor: () ->
    that = this
    that.client = dropbox.client
    that.folder = config.get 'folder'

  readPath = (path, callback) ->
    console.log path
    that.client.readdir that.folder + '/'+ path, (error, entries) ->
      callback error, entries

  getArtists: (callback) ->
    readPath '', callback

  getAlbums: (artist, callback) ->
    readPath artist, callback

  getSongs: (artist, album, callback) ->
    readPath artist + '/' + album, callback

module.exports = DropboxDriver