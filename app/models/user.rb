class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:facebook]

  has_one :account
  has_many :orders, through: :account

  validates :name, :presence => {:message => "-please include your name!"}

  enum role: [:admin, :normal]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email || 'no_omniauth_email_provided@dummy.com'
      user.password = Devise.friendly_token[0,20]
      user.save
    end
  end
end
