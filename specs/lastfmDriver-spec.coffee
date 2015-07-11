expect = require 'expect.js'
queue = require '../../dist/browser/core/cover/lastfm-driver.js'

describe 'LastFmCoverDriver', ->
  it 'should create a instance of driver', (done) ->
    Instance = new LastFmCoverDriver('Coldplay', 'Parachutes')
    expect(Instance.toJSON()).to.have.length(0)
    done
