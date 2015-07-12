expect = require 'expect.js'
LastFmCoverDriver = require '../../dist/browser/core/cover/lastfm-driver.js'

describe 'LastFm Driver for Covers', ->

  it 'should get a cover', (done) ->

    @timeout = 10000
    driver = new LastFmCoverDriver 'Coldplay', 'Parachutes'
    driver.on 'success', (cover) ->
      expect(cover).to.not.be.empty()
      do done

  it 'should not get a cover that not exists', (done) ->

    @timeout = 10000
    driver = new LastFmCoverDriver 'Rodolfo', 'R.A.B.T'
    driver.on 'error', (error) ->
      expect(error.message).to.be('Cover not found')
      do done

  it 'should not get a cover', (done) ->

    @timeout = 10000
    driver = new LastFmCoverDriver 'Igreja Batista Sal & Luz', 'Metanóia 2015.1'
    driver.on 'error', (error) ->
      expect(error.message).to.be('Artist not found')
      do done
