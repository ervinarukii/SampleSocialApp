class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.text :body
      t.references :user, index: true

      t.timestamps
    end
  end
end
