class User < ActiveRecord::Base

  has_many :events
  has_and_belongs_to_many :events

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
  :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    if self.where(email: auth.info.email).exists?
      email = auth.info.email
      Rails.logger.info ">>>>#{email} exists<<<<"
      return_user = self.where(email: email).first
      return_user.provider = auth.provider
      return_user.uid = auth.uid
    else
      return_user = self.create do |user|
       user.provider = auth.provider
       user.uid = auth.uid
       user.email = auth.info.email
       user.password = Devise.friendly_token[0,20]
       user.save!
     end
   end
   return_user
 end

 def self.new_with_session(params, session)
  if session["devise.user_attributes"]
    new(session["devise.user_attributes"], without_protection: true) do |user|
      user.attributes = params
      user.valid?
    end
    else
      super
    end
  end

end
