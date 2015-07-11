expect = require 'expect.js'
LastFmCoverDriver = require '../../dist/browser/core/cover/lastfm-driver.js'

describe 'LastFmCoverDriver', ->
  it 'should create a instance of driver', (done) ->
    Instance = new LastFmCoverDriver('Coldplay', 'Parachutes')    
    done()
