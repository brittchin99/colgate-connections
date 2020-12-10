class CreateConnection < ActiveRecord::Migration[6.0]
  def change
    create_table :connections do |t|
      t.belongs_to :profile, foreign_key: true
      t.belongs_to :friend
      
t.timestamps
    end
  end
end
