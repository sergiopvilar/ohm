Model = require './model'

class Album extends Model

  constructor: () ->    
    return super('albums')

module.exports = new Album