# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  admin_key  :string           default(""), not null
#  public_key :string           default(""), not null
#  slug       :string           default(""), not null
#  title      :string           default(""), not null
#  provider   :integer
#  slide_url  :string           default(""), not null
#  html       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_rooms_on_admin_key_and_public_key  (admin_key,public_key) UNIQUE
#  index_rooms_on_user_id                   (user_id)
#

class Room < ApplicationRecord
  belongs_to :user
  before_validation :generate_key

  enum provider: { SlideShare: 1, SpeakerDeck: 2 }

  VALID_SLUG_REGEX = /\A[0-9A-Za-z\-_]+\z/ # 英数と - _ の 2 つの半角記号
  validates :title,        presence: true
  validates :slug,         presence: true, format: { with: VALID_SLUG_REGEX }
  validates :public_key,   presence: true, format: { with: VALID_SLUG_REGEX }
  validates :admin_key,    presence: true, format: { with: VALID_SLUG_REGEX }

  def owner_display_name
    user.try(:display_name) || '未登録'
  end

  def owner_username
    user.try(:username)
  end

  def owner?(user)
    user_id == user.try!(:id)
  end

  # iframeだけを抽出する
  def excute_iframe!
    self.html = self.html.match(/<iframe.*>.*<\/iframe>/m)[0]
  end

  private

  def generate_key
    return if self.admin_key? && self.public_key?
    self.admin_key = SecureRandom.urlsafe_base64(8)
    self.public_key = SecureRandom.urlsafe_base64(8)
    self.slug = SecureRandom.urlsafe_base64
  end
end
