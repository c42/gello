class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :project_id
      t.string :title
      t.text :body
      t.integer :github_number
      t.timestamps
    end
  end
end
