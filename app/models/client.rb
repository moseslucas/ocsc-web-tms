class Client < ApplicationRecord
  # validates :name, :amount, :discount_type, presence: true
  # validates :amount, numericality: {only_integer: true, less_than: 101, greater_than: -1}
  scope :search, -> (filter) { 
    where(
      "(name ILIKE ?) OR
      (description ILIKE ?) OR
      (contact ILIKE ?) OR
      (email ILIKE ?) OR
      (address ILIKE ?) OR
      (credit_limit = ?)",
      "%#{filter.strip}%",
      "%#{filter.strip}%",
      "%#{filter.strip}%",
      "%#{filter.strip}%",
      "%#{filter.strip}%",
      filter.strip.to_i
    )
  }

  has_many :documents
  belongs_to :discount, optional:true
end
