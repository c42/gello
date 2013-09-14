class Project < ActiveRecord::Base
  has_many :cards

  attr_accessible :handle, :repository, :github_path

  def self.find_or_fetch(handle, name, options = {})
    project = where(handle: handle, repository: name).first
    return project unless project.nil?
    begin
      github_project = Octokit::Client.new(access_token: options[:access_token]).repository("#{handle}/#{name}")
      create(handle: handle, repository: name, github_path: github_project.full_name).tap do |p|
        Card.initial_fetch(github_project, p)
      end
    rescue Octokit::NotFound
      raise ActiveRecord::RecordNotFound
    end
  end
end
