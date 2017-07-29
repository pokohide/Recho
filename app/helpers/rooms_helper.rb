module RoomsHelper
  def iframe_format html
    Sanitize.fragment(html,
      elements: %w[iframe],
      attributes: {
        'iframe' => %w[src width height frameborder marginwidth marginheight scrolling style allowfullscreen ]
      },
      add_attributes: {
        'iframe' => { 'width' => '100%', 'height' => '100%'}
      }
    ).html_safe
  end
end
