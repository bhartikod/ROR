class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :fname
      t.string :lname
      t.text :address

      t.timestamps
    end
  end
end
