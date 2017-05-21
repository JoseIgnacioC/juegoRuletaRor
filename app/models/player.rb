class Player < ApplicationRecord
	has_and_belongs_to_many :rounds
end
