expect = require 'expect.js'
library = require '../../dist/browser/core/library/library.js'
cache = require('../../dist/browser/core/cache/cache.js')('./.tmp')

describe 'Cache', ->

  it 'Should load the database', (done) ->

    library.update()
    library.on 'complete', ->
      do done
