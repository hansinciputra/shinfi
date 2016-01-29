class CreateProdtypes < ActiveRecord::Migration
  def change
    create_table :prodtypes do |t|

      t.timestamps
    end
  end
end
