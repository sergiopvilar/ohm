Model = require './model'

class Config extends Model

  constructor: () ->    
    instance = super('config')
    db = instance.db

    if db.object.config.constructor.name is "Array"
      db.object.config = {
        "_": "_"
      }
      do db.save

    instance.get = (key) ->
      if db.object.config?
        return db.object.config[key]
      else
        return false

    instance.set = (key, value) ->
      db.object.config[key] = value
      do db.save
      instance.emit('updated')
      instance.emit(key+'_updated')

    return instance

module.exports = new Config