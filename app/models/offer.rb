class Offer < ApplicationRecord
  STATUSES = %w(created accepted rejected)

  enum status: STATUSES.zip(STATUSES).to_h

  belongs_to :salesman, class_name: 'User'
  belongs_to :client, class_name: 'User'
  has_many :products

  validates :products, presence: true

  accepts_nested_attributes_for :products
end
