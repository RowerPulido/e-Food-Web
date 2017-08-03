class CreateEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations do |t|
      t.integer :client_id
      t.integer :dish_id
      t.integer :calification
      t.timestamps
    end
  end
end
