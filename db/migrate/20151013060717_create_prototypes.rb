class CreatePrototypes < ActiveRecord::Migration
  def change
    create_table :prototypes do |t|
      t.string :filename
      t.string :directory

      t.timestamps null: false
    end
  end
end
