class Client < ApplicationRecord
  belongs_to :discount, optional: true
end
