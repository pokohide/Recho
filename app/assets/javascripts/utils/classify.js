export default class Classify {
  constructor() {
  }

  excute(url) {
    if (this._isSlideShare(url)) return 'slideshare'
    if (this._isSpeakerDeck(url)) return 'speakerdeck'
    return null
  }

  _isSlideShare(url) {
    const regexp = new RegExp(/^https?:\/\/www\.slideshare\.net\/([a-zA-Z0-9-]+)\/([a-zA-Z0-9-]+)\/?/)
    //return url.match(url)
    return regexp.test(url)
  }

  _isSpeakerDeck(url) {
    const regexp = new RegExp(/^https?:\/\/speakerdeck\.com\/([a-zA-Z0-9-]+)\/([a-zA-Z0-9-]+)\/?/)
    return regexp.test(url)
  }
}
