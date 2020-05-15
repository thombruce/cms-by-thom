class CreateUploads < ActiveRecord::Migration[6.0]
  def change
    create_table :uploads do |t|
      t.references :workspace, null: false, foreign_key: true

      t.timestamps
    end
  end
end
