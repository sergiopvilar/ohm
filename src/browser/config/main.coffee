merge = require 'merge'
fs = require 'fs'

opts = {}
override = {}

file = './config_default.js'

if process.env.NODE_ENV? and fs.existsSync(__dirname + '/config_'+process.env.NODE_ENV + '.js')
  file = './config_'+process.env.NODE_ENV + '.js'
override = require file

module.exports = merge(opts, override)
