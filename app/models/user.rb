# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  username               :string           default(""), not null
#  display_name           :string
#  image                  :string
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  mount_uploader :image, ThumbnailUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i[twitter facebook]

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :display_name, presence: true
  validates :username, presence: true, username: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  # References
  has_many :rooms, dependent: :destroy

  def self.find_for_oauth(auth)
    # providerとuidでUserレコードを取得する。存在しない場合は、ブロック内のコードを実行して作成
    # user = User.where(provider: auth.provider, uid: auth.uid).first
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    unless user
      binding.pry
      user = User.new(
        uid: auth.uid,
        provider: auth.provider,
        username: auth.info.nickname,
        display_name: auth.info.name,
        email: User.get_email(auth),
        # password: Devise.friendly_token[4, 30],
        image: auth.info.image
      )
      user.skip_confirmation!
      user.save!
    end
    user
  end

  # Devise の RegistrationsController はリソースを生成する前にself.new_with_controllerを呼ぶ
  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  # providerがある場合はパスワードを要求しないようにする
  def password_required?
    super && provider.blank?
  end

  # プロフィールを変更する時に呼ばれる
  def update_with_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    clean_up_passwords
    update_attributes(params, *options)
  end

  def self.get_email(auth)
    email = auth.info.email
    email = "#{auth.provider}-#{auth.uid}@example.com" if email.blank?
    email
  end
end
