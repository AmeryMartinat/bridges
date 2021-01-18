class Bridge < ApplicationRecord
  has_many :travelers
  belongs_to :trip
  accepts_nested_attributes_for :travelers, reject_if: :all_blank, allow_destroy: true
end
