class User < ActiveRecord::Base
   acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  user = User.where(:provider => auth.provider, :uid => auth.uid).first
  unless user
    
    user = User.create(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20],
                         first_name:auth.extra.raw_info.first_name, 
                         last_name:auth.extra.raw_info.last_name, 
                         link:auth.extra.raw_info.link, 
                         gender:auth.extra.raw_info.gender, 
                         timezone:auth.extra.raw_info.timezone
                         )
  end
  user
end


end