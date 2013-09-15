class AddLaneToCards < ActiveRecord::Migration
  def change
    add_column :cards, :lane, :string
  end
end
