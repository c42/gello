class Organization
  def initialize(octokit_organization, github_access_token)
    @octokit_organization = octokit_organization
    access_token = github_access_token
  end
  
  def login
    @octokit_organization.login
  end
  
  def repos
    octokit_client.paginate(@octokit_organization.rels[:repos].href)
  end
    
  include OctokitHelpers
end