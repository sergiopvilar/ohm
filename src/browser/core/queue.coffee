
class Queue

  constructor: ->
    do @reset

  reset: ->
    @pointer = 0
    @tasks = []
    @running = false

  add: (fn, params, callback) ->
    @tasks.push {
      fn: fn,
      params: params,
      callback: callback
    }

    do @checkForRun

  checkForRun: ->
    unless @running
      do @run

  run: ->
    @pointer = 0
    @running = true
    do @runTask


  runTask: =>
    unless @pointer < @tasks.length
      do @reset
    else
      item = @tasks[@pointer]
      item.fn item.params, (ret) ->
        @pointer++
        @runTask
        if item.callback
          item.callback ret

module.exports = new Queue
