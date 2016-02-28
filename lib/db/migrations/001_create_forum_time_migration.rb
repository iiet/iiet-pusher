class CreateForumTimeMigration < ActiveRecord::Migration
  def change
    create_table :forum_times do |t|
      t.string :atom_id
      t.timestamp :time
    end
  end
end