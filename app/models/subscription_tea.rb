class SubscriptionTea < ApplicationRecord
  belongs_to(:tea)
  belongs_to(:subscription)
end
