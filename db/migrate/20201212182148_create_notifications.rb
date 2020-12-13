class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.belongs_to :profile, foreign_key: true
      t.belongs_to :updater
      t.text :category
      t.text :content
      t.boolean :read

      t.timestamps
    end
  end
end
