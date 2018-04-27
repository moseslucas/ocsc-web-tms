class Calculation < ApplicationRecord
  belongs_to :uom, optional: true
end
