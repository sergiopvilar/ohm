
path = require 'path'
low = require 'lowdb'
config = require '../config/main'

class Database

  db = null

  constructor: ->
    db = low path.join(config.db_path, '/Ohm.db')
    db._.mixin(require 'underscore-db')

  getDB: ->

    return db

module.exports = new Database
