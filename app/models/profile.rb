class Profile < ApplicationRecord
  belongs_to :user

  # after_commit :titleize_name, on: :create

  
  # private
  #   def titleize_name
  #     self.first_name = first_name.downcase.titleize
  #   end

end

  
