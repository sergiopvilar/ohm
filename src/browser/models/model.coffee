path = require 'path'
low = require 'lowdb'
config = require '../config/main'
EventEmitter = require("events").EventEmitter
_ = require 'underscore'

class Model  

  constructor: (@collection) ->
    console.log @collection
    db = low path.join(config.path, '/Ohm.db')
    db._.mixin(require 'underscore-db')

    instance = db(@collection)
    _.extend instance, EventEmitter.prototype
    methods = ['assign', 'remove', 'insert', 'push', 'pull']    

    instance.db = db

    instance.all = () ->
      return instance.toArray()

    override = (method) ->
      instance['_'+method] = instance[method]
      delete instance[method]
      instance[method] = (a) ->
        instance.emit('updated')
        instance['_'+method](a)

    override method for method in methods
    
    return instance

module.exports = Model
