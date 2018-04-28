class Document < ApplicationRecord

  belongs_to :client, optional:true
  belongs_to :kind, optional:true
  belongs_to :calculation, optional:true
  belongs_to :discount, optional:true
  belongs_to :origin, :class_name=>'Company', optional:true
  belongs_to :source, :class_name=>'Location', optional:true
  belongs_to :destination, :class_name=>'Location'


  has_many :payments

  #Associations

  #document details
  # has_many :document_shippings, :class_name=>'DocumentDetail', :foreign_key=>'document_shipping_id'
  # has_many :document_details
  # has_many :document_tags, through: :document_details
  #
  #vehicles
  # has_many :document_vehicles
  # has_many :vehicles, through: :document_vehicles

  #employees
  # has_many :document_employees
  # has_many :employees, through: :document_employees

  #SCOPES
  scope :cargo, -> { where(doc_type: "rec") }
  scope :delivery, -> { where(doc_type: "del") }
  # scope :active, -> { where.not(status1: 0) }
  scope :in_year, -> (year) { where("YEAR(documents.trans_date) = #{year}") }

  scope :search, -> (filter) { 
    where(
      "(ref_id LIKE ?) OR 
      (documents.id LIKE ?) OR
      (trans_date LIKE ?) OR 
      (custom_tag LIKE ?) OR
      (total_amount LIKE ?) OR 
      (released_to LIKE ?) OR 
      (released_date LIKE ?)", 
      "%#{filter.strip}%",
      "%#{filter.strip}%",
      "%#{filter.strip}%",
      "%#{filter.strip}%",
      "%#{filter.strip}%",
      "%#{filter.strip}%",
      "%#{filter.strip}%"
    )
  }

end
