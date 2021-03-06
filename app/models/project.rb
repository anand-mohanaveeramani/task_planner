class Project < ActiveRecord::Base
  belongs_to :quarter
  has_many :allocations, dependent: :destroy
  has_many :members, through: :allocations

  attr_accessor :start_date, :end_date, :pts_todo
end
