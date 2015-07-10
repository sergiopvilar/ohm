# Ohm Player

[![Build Status](https://travis-ci.org/OhmPlayer/ohm.svg?branch=master)](https://travis-ci.org/OhmPlayer/ohm)

A music player that streams your music from Dropbox.

# Developing

Ohm is made using [Electron](https://github.com/atom/electron). Read the [Electron documentation](https://github.com/atom/electron/tree/master/docs) for futher information.

## Running

Installing the dependencies:

    npm install -g bower grunt-cli
    npm install && bower install

Running the application:

    npm start

Watching changes in the code:

    grunt watch

Running the tests:

    npm test

Reseting the database:

    rm -rf ~/Library/Application\ Support/Ohm.db
