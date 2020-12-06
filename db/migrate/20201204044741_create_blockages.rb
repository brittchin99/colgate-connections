class CreateBlockages < ActiveRecord::Migration[6.0]
  def change
    create_table :blockages do |t|
      t.belongs_to :profile, foreign_key: true
      t.belongs_to :blockee
      t.timestamps
    end
  end
end
