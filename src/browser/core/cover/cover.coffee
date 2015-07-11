
class Cover

  constructor: (data, @callback) ->
    {@artist, @album} = data
    that = this
    drivers = ['itunes']
    driverCounter = 0
    do getFromDriver

  getFromDriver: ->
    CoverDriver = require './'+drivers[driverCounter]+'-driver.js'
    driver = new CoverDriver(@artist, @album)

    driver.on 'success', ->
      that.callback()

    driver.on 'error', ->
      driverCounter++
      unless driverCounter is drivers.length
        do getFromDriver
      else
        that.callback()

module.exports = Cover
