class Quarter < ActiveRecord::Base
  has_many :projects, -> { order :priority }, dependent: :destroy

  def name
    "#{year}-Q#{index}"
  end
end
