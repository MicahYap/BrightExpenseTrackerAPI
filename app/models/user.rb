class User < ApplicationRecord
  has_many :expenses
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
