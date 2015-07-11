EventEmitter = require("events").EventEmitter
_ = require 'underscore'
fs = require 'fs'
Song = require '../../models/song.js'

class Cache
  _.extend @prototype, EventEmitter.prototype

  constructor: (@cacheDir) ->
    if not fs.existsSync @cacheDir
      fs.mkdirSync @cacheDir

  getOrDownload: (songId, callback) ->
    _song = Song.find({id: songId}).value()
    if not fs.existsSync @cacheDir + '/' + songId

      Driver = require './' + _song.driver + '-downloader.js'
      dv = new Driver(_song.path, @cacheDir + '/' + songId)

      dv.on 'error', (message) ->
        console.log message
        callback false

      dv.on 'success', ->
        callback @cacheDir + '/' + songId

    else
      callback @cacheDir + '/' + songId

module.exports = new Cache
