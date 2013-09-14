class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string "handle"
      t.string "repository"
      t.string "github_path"
      t.timestamps
    end
  end
end
