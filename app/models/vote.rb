class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  
  before_save :default_value

  def default_value
    self.value ||= 0
  end  
end
