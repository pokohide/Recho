class OmniauthCallbacksController < ApplicationController
  def facebook
    callback_from :facebook
  end

  def twitter
    callback_from :twitter
  end

  private

  def callback_from(provider)
    provider = provider.to_s
    @user = User.find_for_oauth(request.env['omniauth.auth']) # providerとuidでuserレコードを検索。存在しなければ、新たに作成する
    if @user.persisted? # ログイン成功
      flash[:notice] = "#{provider}でログインしました。" # cookies.permanent[:xxx_logined] = { value: @user.created_at }
      sign_in_and_redirect @user, event: :authentication
    else # ログインに失敗して、西院画面に遷移
      if provider == 'twitter'
        session['devise.twitter_data'] = request.env['omniauth.auth'].except('extra')
      else
        session['devise.facebook_data'] = request.env['omniauth.auth'].except('extra')
      end
      redirect_to new_user_registration_url
    end
  end
end
