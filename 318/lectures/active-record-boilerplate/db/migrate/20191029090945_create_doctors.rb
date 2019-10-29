class CreateDoctors < ActiveRecord::Migration[5.1]
  def change
    create_table :doctors do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
  end
end
