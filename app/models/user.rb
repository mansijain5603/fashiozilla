class User < ApplicationRecord
  after_create :save_profile  

  has_one :profile, :dependent => :destroy
  has_many :products
  has_many :orders

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email 
  validates_uniqueness_of :email
  validates :phone,:presence => true, :numericality => true, :length => { :minimum => 5, :maximum => 15 }


  attr_accessor :login
  # Include default devise modules. Others available are:
  # :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:lockable,
         :recoverable, :rememberable, :validatable,:confirmable, authentication_keys: [:login]



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
 
def save_profile
  self.create_profile
end

end