# frozen_string_literal: true

class CreateFileResources < ActiveRecord::Migration[7.0]
  def change
    create_table :file_resources do |t|
      t.references :user, null: false, foreign_key: true
      t.string :file

      t.timestamps
    end
  end
end
