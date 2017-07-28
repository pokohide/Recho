crumb :root do
  link 'TOP', root_path
end

# Top > お問い合わせ
crumb :contact do
  link 'お問い合わせ', contact_path
end

# TOP > Rechoについて
crumb :about do
  link 'Rechoとは', about_path
end

# Top > {ユーザ名}
crumb :user do |user|
  link user.display_name, user_path(user)
end

# Top > マイページ
crumb :my_account do
  link 'マイページ', account_path
end

# Top > マイページ > プロフィール編集
crumb :edit_account do
  link 'プロフィール編集', edit_user_registration_path
  parent :my_account
end

# Top > マイアカウント > アップロード
crumb :upload do
  link 'アップロード', upload_path
  parent :my_account
end
