app = require 'app'
BrowserWindow = require 'browser-window'

require('crash-reporter').start()
mainWindow = null;

app.on 'window-all-closed', ->
  #if process.platform is not 'darwin'
  app.quit();

app.on 'ready', ->
  
  mainWindow = new BrowserWindow {width: 800, height: 600}

  mainWindow.loadUrl 'file://' + __dirname + '/renderer/index.html'
  mainWindow.openDevTools()

  mainWindow.on 'closed', ->
    mainWindow = null;
  
