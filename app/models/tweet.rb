class Tweet < ApplicationRecord
    validates :message, presence: true, length: { maximum: 139 }
end
