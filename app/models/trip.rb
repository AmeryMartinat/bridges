class Trip < ApplicationRecord
  has_many :travelers
  has_many :bridges
end
