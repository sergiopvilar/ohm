config = require '../config/main'
userData = require '../models/config'
drop = require 'dropbox'
EventEmitter = require("events").EventEmitter
_ = require 'underscore'

class Dropbox
  _.extend @prototype, EventEmitter.prototype

  constructor: () ->
    
    credentials = userData.get 'credentials'

    @client = new drop.Client {
      key: config.dropbox_key,
      secret: config.dropbox_secret      
    }

    if credentials
      @client.setCredentials credentials

  auth: () ->
    console.log 'Authorizing'
    that = this
    @client.authDriver(new drop.AuthDriver.NodeServer(8912))
    @client.authenticate (error, cc) ->
      if error
        that.emit 'error', error
      userData.set 'credentials', cc.credentials()
      that.emit 'athenticated', cc.credentials()

module.exports = new Dropbox