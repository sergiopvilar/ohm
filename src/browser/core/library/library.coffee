
EventEmitter = require("events").EventEmitter
_ = require 'underscore'
libraryUpdater = require './library-updater.js'

class Library
  _.extend @prototype, EventEmitter.prototype

  drivers = ['dropbox']
  driversCounter = 0
  that = null

  constructor: ->
    that = this

  updatePercentage = (p = false) ->
    percentage = (100 / drivers.length) * driversCounter
    if p
      percentage += (p / drivers.length)
    that.emit 'percentage', percentage
      
  doUpdate = ->
    driverName = drivers[driversCounter]
    driver = require './'+driverName+'-driver.js'
    updater = new libraryUpdater(new driver)

    updater.on 'updating', (artist) ->
      that.emit 'updating', 'Dropbox: #{artist}'

    updater.on 'percentage', (percentage) ->
      updatePercentage percentage

    updater.on 'complete', ->
      driversCounter++
      do updatePercentage
      if driversCounter < drivers.length
        do doUpdate
      else
        that.emit 'complete'

    updater.update()


  update: ->
    do doUpdate


module.exports = new Library
