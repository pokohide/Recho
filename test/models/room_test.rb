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

require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
