class CreatePoems < ActiveRecord::Migration
  def change
    create_table :poems do |t|
      t.string :title
      t.text :content
      t.references :user, index: true, foreign_key: true
    end
  end
end
