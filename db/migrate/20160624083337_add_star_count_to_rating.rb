class AddStarCountToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :star_count, :integer
  end
end
