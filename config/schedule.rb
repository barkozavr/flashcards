# frozen_string_literal: true

every 1.day, at: '03:50 am' do
  runner "User.notify_training_card"
end

every 1.minute do
  runner "User.notify_training_card"
end
