class CreateCollaborators < ActiveRecord::Migration[5.1]
  def change
    create_table :collaborators do |t|
       t.belongs_to :wiki, index: true
       t.belongs_to :user, index: true
       t.timestamps null: false
    end
    add_index :collaborators, :id, unique: true
    add_index :collaborators, :user_id
    add_index :collaborators, :wiki_id

  end
end
