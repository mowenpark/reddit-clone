# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  session_token   :string           not null
#

class User < ActiveRecord::Base
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true
  validate :ensure_session_token

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    @user = User.find_by_email(email)
    if @user.is_password?(password)
      @user
    else
      nil
    end
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.reset_session_token!
  end
end
