class AddNameAndGithubLoginToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :github_login, :string
    add_column :users, :github_avatar_url, :string
  end
end
