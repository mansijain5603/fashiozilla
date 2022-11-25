class User < ApplicationRecord
  after_create :init_profile  

  has_one :profile, :dependent => :destroy
  has_many :products, :dependent => :destroy
  has_one :order, dependent: :destroy
#take into account the the order is a orderslip
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email 
  validates_uniqueness_of :email
  validates_presence_of :phone, unless: -> { from_omniauth? }

  attr_accessor :login
  # Include default devise modules. Others available are:
  # :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:lockable,
         :recoverable, :rememberable, :validatable,:omniauthable, :confirmable, :omniauth_providers => [:google_oauth2], 
         authentication_keys: [:login]

  def login
    @login || self.phone || self.username || self.email
  end
  
  def email_required?
    false
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email)= :value OR lower(phone)= :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:phone) || conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
end

def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0,20]
        )
      end
    user.skip_confirmation!
    user.uid = access_token.uid
    user.provider = access_token.provider
    user.save
      user
  end

 
def init_profile
  self.create_profile!
end

def save_order
    self.create_order
end

private

def from_omniauth?
  provider && uid
end

end

