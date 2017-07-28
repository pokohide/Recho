import Classify from '../../utils/classify'
import Oembed from '../../utils/oembed'

$('.rooms.new, .rooms.create').ready(() => {
  const classify = new Classify()
  const oembedly = new Oembed()

  /* stepは1, 2とする */
  const changeStep = step => {
    if (![1, 2].includes(step)) return
    const nowStep = ['one', 'two'][step - 1]

    $('.step.active').removeClass('active').addClass('completed')
    $('.step-content.active').removeClass('active')
    $(`.step.${nowStep}`).addClass('active')
    $(`.step-content.${nowStep}`).addClass('active')
  }

  $('#next-step').on('click', () => {
    const url = $('#room_slide_url').val()
    const type = classify.excute(url)
    if (type) {
      oembedly.call(type, url).then((res) => {
        const { body: { success, oembed } } = res
        if (success) {
          changeStep(2)
          $('#room_provider').val(oembed.provider)
          $('#room_title').val(oembed.title)
          $('.slide-preview').html(oembed.html)
          $('#room_html').val(oembed.html)
          $('#upload-button').removeClass('disabled')
          $('#next-step').removeClass('loading')
        }
      })
      .catch((err) => {
        console.log('エラーが発生しました。', err)
      })
    } else {
      console.log('形式が違います。')
    }
  })

  $('#prev-step').on('click', () => {
    changeStep(1)
    $('#upload-button').addClass('disabled')
  })
})
