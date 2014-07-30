def create_user(overrides = {})
  User.create!({
    name: 'Some User',
    email: 'user@example.com',
    password: 'password',
    password_confirmation: 'password'
  }.merge(overrides))
end

def create_subscribers

  user_11 = User.create!(
    name: "Miss Kip Torp",
    email: 'user11@example.com',
    password: 'password',
    password_confirmation: 'password'
  )

  SubscriptionEvent.create!(
    user: user_11,
    event_type: 'subscribed',
    date: Date.today.beginning_of_month - 6.months,
    price_per_month_in_cents: 700,
  )

  user_12 = User.create!(
    name: "Gretchen Langosh",
    email: 'user12@example.com',
    password: 'password',
    password_confirmation: 'password'
  )

  SubscriptionEvent.create!(
    user: user_12,
    event_type: 'subscribed',
    date: Date.today.beginning_of_month - 14.months,
    price_per_month_in_cents: 1000,
  )
  SubscriptionEvent.create!(
    user: user_12,
    event_type: 'unsubscribed',
    date: Date.today.beginning_of_month - 13.months,
    price_per_month_in_cents: 0,
  )

end