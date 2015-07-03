EventEmitter = require("events").EventEmitter
_ = require 'underscore'

# Models
Artist = require '../models/artist'
Album = require '../models/album'
Song = require '../models/song'

console.log Artist

class LibraryUpdater
  _.extend @prototype, EventEmitter.prototype

  that = null
  constructor: (driver) ->
    that = this
    that.driver = driver

  artistCounter = 0
  albumCounter = 0
  songCounter = 0

  update: () ->    
    that.driver.getArtists (err, artists) ->      
      that.artists = artists      
      registerArtist () ->
        that.emit('complete')

  updateStatus = () ->
    percentage = (artistCounter/that.artists.length) * 100
    that.emit 'percentage', percentage

  registerArtist = (callback) ->
    
    artistName = that.artists[artistCounter]
    artist_id = Artist.insert({name: artistName}).id
    albumCounter = 0

    that.emit 'updating', artistName

    console.log 'Registering artist: '+ artistName

    that.driver.getAlbums artistName, (err, albums) ->
      that.albums = albums
      registerAlbum artist_id, () ->
        artistCounter++
        if artistCounter < that.artists.length
          registerArtist callback
        else
          do callback


  registerAlbum = (artist_id, callback) ->
    
    artistName = that.artists[artistCounter]
    albumName = that.albums[albumCounter]
    album_id = Album.insert({name: albumName, artist_id: artist_id }).id
    songCounter = 0

    console.log 'Registering album: '+ albumName

    that.driver.getSongs artistName, albumName, (err, songs) ->
      that.songs = songs
      registerSong artist_id, album_id, () ->
        albumCounter++
        if albumCounter < that.albums.length
          registerAlbum artist_id, callback
        else
          do callback

  registerSong = (artist_id, album_id, callback) ->

    songName = that.songs[songCounter]
    albumName = that.albums[albumCounter]
    artistName = that.artists[artistCounter]
    song_id = Song.insert({
      name: songName, 
      album_id: album_id
      artist_id: artist_id
    }).id

    console.log 'Registering song: '+ songName
    
    songCounter++
    if songCounter < that.songs.length
      registerSong artist_id, album_id, callback
    else
      do callback


module.exports = LibraryUpdater
