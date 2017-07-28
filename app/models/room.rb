# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  admin_key  :string           default(""), not null
#  public_key :string           default(""), not null
#  title      :string           default(""), not null
#  slide_url  :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  provider   :integer
#  html       :text
#
# Indexes
#
#  index_rooms_on_admin_key_and_public_key  (admin_key,public_key) UNIQUE
#  index_rooms_on_user_id                   (user_id)
#

class Room < ApplicationRecord
  belongs_to :user
  before_validation :generate_key

  # iframeだけを抽出する
  def excute_iframe!
    self.html = self.html.match(/<iframe.*>.*<\/iframe>/m)[0]
  end

  private

  def generate_key
    return if self.admin_key? && self.public_key?
    self.admin_key = SecureRandom.urlsafe_base64(8)
    self.public_key = SecureRandom.urlsafe_base64(8)
  end
end
