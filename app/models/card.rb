class Card < ActiveRecord::Base
  attr_accessible :title, :body, :project_id, :github_number, :lane
  UNSORTED = "unsorted"
  READY_FOR_DEV = "ready_for_dev"
  IN_PROGRESS = "in_progress"
  COMPLETED = "completed"

  def self.initial_fetch(github_project, project)
    return unless github_project.open_issues_count > 0
    issue_collection = github_project.rels[:issues].get
    issues = issue_collection.data
    while issue_collection.rels[:next]
      issue_collection = issue_collection.rels[:next].get
      issues += issue_collection.data
    end
    issues.collect do |i|
      create(title: i.title, body: i.body, project_id: project.id, github_number: i.number, lane: UNSORTED)
    end
  end
end
