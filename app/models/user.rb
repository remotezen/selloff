class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :bids
  has_many :sellers
  has_many :products

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :authentication_keys => [:login]

  attr_accessor :login
  validates :username,
    presence: true,
    uniqueness: {case_sensitive: false}
  after_initialize :create_login, :if => :new_record?

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end
  def create_login
      if self.username.blank?
        email = self.email.split(/@/)
        login_taken = User.where(:username => email[0]).first
        unless login_taken
          self.username = email[0]
        else
          self.username = self.email
        end
      end
  end

  def email_require?
     false
  end

end
