class CreateFileArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :file_archives do |t|
      t.references :user, null: false, foreign_key: true
      t.string :file_path
      t.string :zipfile_path
      t.string :password
      t.string :status
      t.string :error

      t.timestamps
    end
  end
end
