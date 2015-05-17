class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_access
  before_filter :focus_quarter

  helper_method :focus_quarter

  def authenticate_access
    redirect_to login_path unless session[:signed_in] || (controller_name == "main" && ["login", "authenticate"].include?(action_name))
  end

  def focus_quarter
    @focus_quarter ||= Quarter.find_by(year: Time.now.year, index: (1 + ((Time.now.month-1)/3).to_i))
  end

  def holiday?(date)
    build_holidays_cache if @holidays_cache.nil?
    @holidays_cache[date] == true
  end

  def build_holidays_cache
    @holidays_cache = {}
    quarter_start = Date.today.beginning_of_quarter
    next_quarter_end = Date.today.end_of_quarter.next.end_of_quarter
    Leave.where(leave_date: (quarter_start..next_quarter_end), member_id: nil).each do |holiday|
      @holidays_cache[holiday.leave_date] = true
    end
    (quarter_start..next_quarter_end).each {|d| @holidays_cache[d] = d.saturday? || d.sunday? }
  end
end
