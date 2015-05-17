class Quarter < ActiveRecord::Base
  has_many :projects, -> { order :priority }

  def name
    "#{year}-Q#{index}"
  end
end
