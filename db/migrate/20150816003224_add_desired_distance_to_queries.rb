class AddDesiredDistanceToQueries < ActiveRecord::Migration
  def change
    add_column :queries, :desired_distance, :number
  end
end
