EventEmitter = require("events").EventEmitter
_ = require 'underscore'
fs = require 'fs'
queue = require '../queue.js'
Song = require '../../models/song.js'

class Cache
  _.extend @prototype, EventEmitter.prototype

  constructor: (@cacheDir) ->
    if not fs.existsSync @cacheDir
      fs.mkdirSync @cacheDir

  getOrDownload: (songId, callback) =>
    _song = Song.find({id: songId}).value()
    if not fs.existsSync @cacheDir + '/' + songId
      @save songId, callback
    else
      callback @cacheDir + '/' + songId

  save: (songId, callback) ->
    _song = Song.find({id: songId}).value()

    Driver = require './' + _song.driver + '-downloader.js'
    dv = new Driver(_song.path, @cacheDir + '/' + songId)

    dv.on 'error', (message) ->
      console.log message
      callback false

    dv.on 'success', ->
      callback @cacheDir + '/' + songId

  removeSong: (song, callback) ->
    if fs.existsSync @cacheDir + '/' + song.id
      fs.unlinxSync @cacheDir + '/' + song.id
      Song.chain().where(song).assign({last_played: 0})
      do callback if callback

  cleanUp: (params, callback) ->
    diff = 2 * 24 * 60 * 60 * 1000 # 2 days
    songs = Song.chain().value()
    for song in songs
      unless song.last_played is 0
        now = new Date().getTime()
        if (now - song.last_played) > diff
          queue.add @removeSong, song


module.exports = (path) -> new Cache path
