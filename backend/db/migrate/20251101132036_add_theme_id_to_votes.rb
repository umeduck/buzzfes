class AddThemeIdToVotes < ActiveRecord::Migration[7.1]
  def change
    add_reference :votes, :theme, null: false, foreign_key: true, after: :post_id
  end
end
