module.exports = {

  toBuffer: (ab) ->
    buffer = new Buffer(ab.byteLength)
    view = new Uint8Array(ab)
    i = 0
    while i < buffer.length
      buffer[i] = view[i]
      ++i

    return buffer;

}
