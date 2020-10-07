class User < ApplicationRecord
  has_secure_password

  ROLES = %w(client salesman admin)

  enum role: ROLES.zip(ROLES).to_h

  validates :email, presence: true
  validates :role, presence: true
end
