expect = require 'expect.js'
queue = require '../../dist/browser/core/queue.js'

describe 'Queue', ->

  it 'Should register a task and run', (done) ->

    counter = 0

    task = (parameters, cb) ->
      setTimeout ->
        counter++
        do cb
      , 1000

    queue.add task, null, ->
      do done
