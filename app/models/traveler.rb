class Traveler < ApplicationRecord
  has_one :trip
  has_one :bridge

  def self.get_name
    names = %w[Adam Alex Aaron Ben Carl Dan David Edward Fred Frank George Hal Hank Ike John Jack Joe Larry
            Monte Matthew Mark Nathan Otto Paul Peter Roger Roger Steve Thomas Tim Ty Victor Walter Emma Olivia
            Ava Isabella Sophia Taylor Charlotte Amelia Evelyn Abigail Mary Patricia Linda Barbara Elizabeth
            Jennifer Maria Susan Margaret Dorothy Dora]
    names[rand(names.size)]
  end
end
