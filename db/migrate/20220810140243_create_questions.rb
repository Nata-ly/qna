class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.text :body, nul: false
      t.string :title, nul: false

      t.timestamps
    end
  end
end
