expect = require 'expect.js'
Driver = require '../../dist/browser/core/cover/itunes-driver.js'

describe 'iTunes Driver for Covers', ->

  it 'should get a cover', (done) ->

    @timeout = 10000
    driver = new Driver 'Coldplay', 'Parachutes'

    driver.on 'success', (cover) ->
      expect(cover).to.contain('.jpg')
      expect(cover).to.contain('100x100')
      do done

  it 'shoud not get a cover', (done) ->

    @timeout = 10000
    driver = new Driver 'MC Brinquedo', 'Meça suas palavras parça'

    driver.on 'error', (error) ->
      expect(error.message).to.be('Cover not found')
      do done
