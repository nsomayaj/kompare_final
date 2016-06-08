class Restaurant < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => { :scope => :city }
end
