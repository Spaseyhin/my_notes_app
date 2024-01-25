class Note < ApplicationRecord
	validates :pinned, inclusion: { in: [true, false] }
	validates :completed, inclusion: { in: [true, false] }, allow_nil: true
end
