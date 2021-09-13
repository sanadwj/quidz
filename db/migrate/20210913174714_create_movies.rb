class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :movie
      t.string :description
      t.string :year
      t.string :director
      t.string :actore, null: false, array: true
      t.string :filming_location
      t.string :country

      t.timestamps
    end
  end
end
