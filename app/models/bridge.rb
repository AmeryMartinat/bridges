class Bridge < ApplicationRecord
  has_many :travelers
  belongs_to :trip
  accepts_nested_attributes_for :travelers, reject_if: :all_blank, allow_destroy: true


  def prior_new_travelers
      prior_travelers = []
      prior_bridges = self.trip.bridges.where("id < #{self.id}")
      if prior_bridges.length > 0
        prior_bridges.each do |b|
        prior_travelers += b.travelers
        end
      end
      prior_travelers

  end
end
