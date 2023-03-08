class DropCropperData < ActiveRecord::Migration[7.0]
  def change
    drop_table :cropper_data
  end
end
