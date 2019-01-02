class CreateAttachements < ActiveRecord::Migration
  def change
    create_table :attachements do |t|
      t.string :name
      t.string :attachment

      t.timestamps
    end
  end
end
