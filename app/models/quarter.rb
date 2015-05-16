class Quarter < ActiveRecord::Base
  has_many :projects

  def name
    "#{year}-Q#{index}"
  end
end
