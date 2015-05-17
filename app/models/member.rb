class Member < ActiveRecord::Base
  has_many :allocations
  has_many :projects, through: :allocations
end
