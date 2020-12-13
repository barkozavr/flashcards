# frozen_string_literal: true

# every 1.day, at: '11:38 pm' do
#   runner "User.notify_training_card"
# end

every 1.minute do
  runner "User.notify_training_card"
end
