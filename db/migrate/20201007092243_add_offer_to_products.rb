class AddOfferToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :offer, null: false, foreign_key: true
  end
end
