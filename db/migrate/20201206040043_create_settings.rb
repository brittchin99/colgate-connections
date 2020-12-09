class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.text :notifs
      t.text :public
      t.boolean :dating

      t.belongs_to :profile, foreign_key: true 
      t.timestamps
    end
  end
end
