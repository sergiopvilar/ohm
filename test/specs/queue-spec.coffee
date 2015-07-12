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

  it 'Should call a task each', (done) ->

    @timeout 5000
    counter = 0

    queue.add (parameters, cb) ->
      setTimeout ->
        counter++
        do cb
      , 300
    , null, false

    queue.add (parameters, cb) ->
      counter++
      do cb
    , null, ->
      expect(counter).to.be(2)
      do done
