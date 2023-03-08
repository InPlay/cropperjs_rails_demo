# This migration comes from croppable (originally 20230303170333)
class CreateCroppableData < ActiveRecord::Migration[7.0]
  def change
    create_table :croppable_data do |t|
      t.references :croppable, polymorphic: true
      t.string :name
      t.integer :x
      t.integer :y
      t.float   :scale
      t.string  :background_color

      t.timestamps
    end
  end
end
