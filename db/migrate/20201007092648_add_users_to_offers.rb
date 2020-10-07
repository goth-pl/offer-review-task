class AddUsersToOffers < ActiveRecord::Migration[6.0]
  def change
    add_reference :offers, :salesman, null: false, foreign_key: { to_table: :users }
    add_reference :offers, :client, null: false, foreign_key: { to_table: :users }
  end
end
