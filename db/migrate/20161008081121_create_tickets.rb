class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.integer :owner_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
