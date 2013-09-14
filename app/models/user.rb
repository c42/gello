class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :provider, :uid
  
  def self.find_or_create_from_oauth(auth)
    record = where(provider: auth.provider, uid: auth.uid.to_s).first
    record || create!(provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0,20])
  end
  
  def repos(github_access_token)
    client = Octokit::Client.new(access_token: github_access_token)
    client.user.rels[:repos].get.data || []
  end
end
