class Api::V1::OembedsController < ApplicationController

  def show
    get_oembed(params[:url]) if @success = is_url?(params[:url])
  end

  private

  def get_oembed(url)
    OEmbed::Providers.register_all
    @res = OEmbed::Providers.get(url)
  end

  def is_url?(str)
    regexp = /\A#{URI::regexp(%w(http https))}\z/
    str =~ regexp ? true : false
  end
end
