class CreateMicrosamples < ActiveRecord::Migration
  def change
    create_table :microsamples do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :microsamples, [:user_id, :created_at]
  end
end
