class CreateCropperData < ActiveRecord::Migration[7.0]
  def change
    create_table :cropper_data do |t|
      t.references :cropable, polymorphic: true

      t.string :name
      t.integer :x
      t.integer :y
      t.float :scale
      t.string :background_color
      t.integer :index

      t.timestamps
    end
  end
end
