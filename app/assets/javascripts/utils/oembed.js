const request = require('superagent')

export default class Oembed {
  constructor() {
  }

  call(type, target) {
    return this._get(type, target)
  }

  _get(type, url) {
    return new Promise((resolve, reject) => {
      request
        .get('/api/v1/oembed')
        .query({ url: url, type: type })
        .accept('application/json')
        .type('application/json')
        .set("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'))
        .set('Acces-Control-Allow-Origin', '*')
        .end((err, res) => {
          if (err) { return reject(err) }
          else { return resolve(res) }
        })
    })
  }
}
