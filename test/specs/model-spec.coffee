expect = require 'expect.js'

describe 'Model', ->

  it 'Should create a new instance of model', ->

    Model = require '../../dist/browser/models/model.js';
    Instance = new Model('albums')
    expect(Instance.toJSON()).to.have.length(0)

  it 'Should create a new Album model', ->

    Album = require '../../dist/browser/models/album.js';
    expect(Album.toJSON()).to.have.length(0)
