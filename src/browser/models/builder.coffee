path = require 'path'

ModelBuilder = (name) ->
  Model = require path.join __dirname, '/', name + '.js'
  return Model
    
module.exports = ModelBuilder
      