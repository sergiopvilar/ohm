Model = require './model'

class Song extends Model

  constructor: () ->    
    return super('songs')

module.exports = Song