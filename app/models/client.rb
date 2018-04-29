class Client < ApplicationRecord
  has_many :documents
  belongs_to :discount, optional: true
end
