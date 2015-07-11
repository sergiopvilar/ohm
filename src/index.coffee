app = require 'app'
BrowserWindow = require 'browser-window'

library = require __dirname + '/browser/core/library/library.js'

require('crash-reporter').start()
mainWindow = null

config = require './browser/models/config'
view = if config.get('credentials') and config.get('folder') then '' else '#/setup'
width = if view is '' then 1024 else 512

app.on 'window-all-closed', ->
  #if process.platform is not 'darwin'
  app.quit()

app.on 'ready', ->

  mainWindow = new BrowserWindow {width: width, height: 600}
  mainWindow.loadUrl 'file://' + __dirname + '/renderer/index.html'+view
  #mainWindow.openDevTools()

if view is ''
  library.update()

  mainWindow.on 'closed', ->
    mainWindow = null
