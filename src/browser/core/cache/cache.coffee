EventEmitter = require("events").EventEmitter
_ = require 'underscore'
fs = require 'fs'
queue = require '../queue.js'
Song = require '../../models/song.js'

class Cache
  _.extend @prototype, EventEmitter.prototype

  xCounter = 0
  yCounter = 0
  cleanUpCallback = null
  cacheDir = null

  constructor: (_cacheDir) ->
    cacheDir = _cacheDir
    if not fs.existsSync cacheDir
      fs.mkdirSync cacheDir

  getOrDownload: (songId, callback) =>
    _song = Song.chain().find({id: songId}).value()
    if not fs.existsSync cacheDir + '/' + songId
      @save songId, callback
    else
      callback @cacheDir + '/' + songId

  save: (songId, callback) ->
    _song = Song.chain().find({id: songId}).value()

    Driver = require './' + _song.driver + '-downloader.js'
    dv = new Driver(_song.path, cacheDir + '/' + songId)

    dv.on 'error', (message) ->
      console.log message
      callback false

    dv.on 'success', ->
      callback @cacheDir + '/' + songId

  removeSong: (song, callback) ->    
    fs.existsSync cacheDir + '/' + song.id
    if fs.existsSync cacheDir + '/' + song.id
      fs.unlinkSync cacheDir + '/' + song.id
      Song.chain().where(song).assign({last_played: 0})
      do callback if callback
    else
      do callback if callback

  checkCleanup: () ->
    yCounter++
    if xCounter is yCounter
      do cleanUpCallback

  cleanUp: (params, callback) ->
    cleanUpCallback = callback
    xCounter = 0
    yCounter = 0
    diff = 2 * 24 * 60 * 60 * 1000 # 2 days
    songs = Song.chain().value()

    for song in songs
      unless song.last_played is 0
        now = new Date().getTime()
        if (now - song.last_played) > diff
          xCounter++
          queue.add @removeSong, song, @checkCleanup

    if xCounter is 0
      do callback




module.exports = (path) -> new Cache path
