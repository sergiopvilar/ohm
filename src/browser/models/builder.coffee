path = require 'path'

ModelBuilder = (name) ->
  Model = require path.join __dirname, '/', name + '.js'
  return new Model
    
module.exports = ModelBuilder
      