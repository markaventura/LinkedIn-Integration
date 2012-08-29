class Home < ActiveRecord::Base
  attr_accessible :email, :name, :mydocument

  has_attached_file :mydocument, :path => ":rails_root/public/data/:id/:basename.:extension"
end
