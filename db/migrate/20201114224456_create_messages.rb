class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :conversation, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.boolean :read

      t.timestamps
    end
  end
end
