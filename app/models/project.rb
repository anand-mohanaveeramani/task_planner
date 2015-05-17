class Project < ActiveRecord::Base
  belongs_to :quarter
  has_many :allocations
  has_many :members, through: :allocations
end
