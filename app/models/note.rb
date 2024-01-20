class Note < ApplicationRecord
	validates :pinned, inclusion: { in: [true, false] }
end
