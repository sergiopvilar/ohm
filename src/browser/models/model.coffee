
EventEmitter = require("events").EventEmitter
_ = require 'underscore'
database = require '../core/database.js'

class Model  

  constructor: (@collection) ->
    
     
    db = database.getDB()

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
