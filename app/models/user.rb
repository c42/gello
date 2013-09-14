class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :provider, :uid, :name, :github_login, :github_avatar_url
  
  attr_accessor :access_token                
  
  def self.find_or_create_from_oauth(auth)
    record = where(provider: auth.provider, uid: auth.uid.to_s).first
    record ||= create(provider: auth.provider, uid: auth.uid, email: auth.info.email, 
                    password: Devise.friendly_token[0,20])
    record.tap do |r|
      r.update_attributes(name: auth.info.name, 
                    github_login: auth.info.nickname, 
                    github_avatar_url: auth.info.image)
      p r.errors.inspect              
    end                      
  end
  
  def repos
    octokit_user.rels[:repos].get.data || []
  end
  
  def avatar_url
    octokit_user.rels[:avatar].href
  end
  
  private
  def octokit_client
    Octokit::Client.new(access_token: access_token)
  end
  
  def octokit_user
    octokit_client.user
  end
end
