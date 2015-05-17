class Member < ActiveRecord::Base
  has_many :allocations
  has_many :projects, through: :allocations
  has_many :leaves
end
