class UsernameValidator < ActiveModel::EachValidator
  RESERVED_WORDS = ['contact', 'about', 'sidekiq', 'cable', 'letter_opener',
    'featured', 'upload', 'account']
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/i

  def validate_each(record, attribute, value)
    unless value =~ VALID_USERNAME_REGEX
      record.errors[attribute] << 'は英数字のみで構成してください'
    end

    if RESERVED_WORDS.include?(value)
      record.errors[attribute] << 'は既に使用されています'
    end
  end
end
