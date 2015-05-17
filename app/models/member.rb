class Member < ActiveRecord::Base
  has_many :allocations
  has_many :projects, through: :allocations
  has_many :leaves

  attr_accessor :available_date

  def next_available_date(date)
    next_date = date.next
    while unavailable?(next_date)
      next_date = next_date.next
    end
    next_date
  end

  def unavailable?(date)
    build_holidays_and_leaves_cache if @holidays_and_leaves_cache.nil?
    @holidays_and_leaves_cache[date] == true
  end

  def build_holidays_and_leaves_cache
    @holidays_and_leaves_cache = {}
    quarter_start = Date.today.beginning_of_quarter
    next_quarter_end = Date.today.end_of_quarter.next.end_of_quarter
    Leave.where(leave_date: (quarter_start..next_quarter_end), member_id: [id, nil]).each do |holiday|
      @holidays_and_leaves_cache[holiday.leave_date] = true
    end
    (quarter_start..next_quarter_end).each {|d| @holidays_and_leaves_cache[d] = (d.saturday? || d.sunday?) }
  end
end
