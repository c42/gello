class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :rememberable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :provider, :uid
  # attr_accessible :title, :body
  
  def self.find_or_create_from_oauth(auth)
    record = where(provider: auth.provider, uid: auth.uid.to_s).first
    record || create(provider: auth.provider, uid: auth.uid, email: auth.info.email)
  end
end
