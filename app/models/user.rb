class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence:  true
  validates :email, presence: true, format: /\A\S+@\S+\z/, uniqueness: {case_sensitive: false}
  validates :password, length: { minimum: 10, allow_blank: true }
  validates :username, presence: true, format: /\A[A-Z0-9]+\z/i, uniqueness: {case_sensitive: false}

  def self.orderedd
    order(created_at: :desc)
  end

  def self.ordereda
    order(created_at: :asc)
  end



  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end






end
