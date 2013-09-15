class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :provider, :uid, :name, :github_login, :github_avatar_url

  def self.find_or_create_from_oauth(auth)
    record = where(provider: auth.provider, uid: auth.uid.to_s).first
    record ||= create(provider: auth.provider, uid: auth.uid, email: auth.info.email,
                    password: Devise.friendly_token[0,20])
    record.tap do |r|
      r.update_attributes(name: auth.info.name,
                    github_login: auth.info.nickname,
                    github_avatar_url: auth.info.image)
    end
  end

  def repos
    octokit_client.paginate(octokit_user.rels[:repos].href)
  end

  def organizations
    octokit_client.paginate(octokit_user.rels[:organizations].href).map {|o| Organization.new(o, access_token) }
  end

  def all_repos_with_issues
    user_repos = repos_with_issues
    organizations.inject(user_repos) do |collection, organization|
      collection + organization.repos_with_issues
    end
  end

  def avatar_url
    octokit_user.rels[:avatar].href
  end

  include OctokitHelpers
end
