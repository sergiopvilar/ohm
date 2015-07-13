expect = require 'expect.js'
fs = require 'fs'
path = require 'path'
tmpPath = path.join __dirname, '..', '..', '.tmp'
library = require '../../dist/browser/core/library/library.js'
cache = require('../../dist/browser/core/cache/cache.js')(tmpPath)
Song = require '../../dist/browser/models/song.js'
_song = null

describe 'Cache', ->

  it 'Should load the database', (done) ->
    library.update()
    library.on 'complete', ->
      do done

  it 'Should get the first song', () ->
    _song = Song.chain().first().value()
    expect(_song.name).to.be('01 Baluarte Melódico.mp3')

  it 'Should download and save a song', (done) ->
    @timeout 20000
    cache.getOrDownload _song.id, (spath) ->
      songPath = path.join tmpPath, _song.id
      expect(spath).not.to.be(false)
      expect(spath).to.be(songPath)
      expect(fs.existsSync(songPath)).to.be(true)
      do done

  it 'Should cleanup the cache', (done) ->
    # @timeout 20000
    Song.chain().find({id: _song.id}).assign({
      last_played: (new Date().getTime() - (2 * 24 * 60 * 60 * 1000) - 2000)
    }).value()
    songPath = path.join __dirname, '..', '..', '.tmp', _song.id
    cache.cleanUp null, () ->
      expect(fs.existsSync(songPath)).to.be(false)
      do done
