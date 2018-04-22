class Discount < ApplicationRecord
  validates :name, :amount, :discount_type, presence: true
  validates :amount, numericality: {only_integer: true, less_than: 101, greater_than: -1}
end
