class ReportsController < ApplicationController

  def current_members
    current_subscribers = []
    User.all.map do |user|
      subscribed = user.subscription_events.map { |event| event.event_type }.last
      current_subscribers << user unless subscribed == 'unsubscribed'
    end
    @current_subscribers = current_subscribers
  end

  def lifetime_value
    lifetime_values = []
    User.all.each do |user|
      if user.subscription_events.present?
        user_lifetime_value = sum_all_months(user)
        lifetime_values << user_lifetime_value
      end
    end
    @lifetime_values = lifetime_values
  end

  private

  def build_months_list(user)
    start_date = user.subscription_events.first.date
    end_date = Date.today.beginning_of_month
    months_list = []
    next_date = start_date
    until next_date == end_date
      months_list << next_date
      next_date += 1.month
    end
    months_list
  end

  def subscription_events_for(user)
    subscription_dates = user.subscription_events.map { |sub| {sub.date => sub.price_per_month_in_cents} }
    subscription_dates.reduce Hash.new, :merge
  end

  def sum_all_months(user)
    subscription_dates = subscription_events_for(user)
    months_list = build_months_list(user)
    sum = 0
    price = user.subscription_events.first.price_per_month_in_cents
    months_list.each do |month|
      if subscription_dates.has_key? month
        price = subscription_dates[month]
      end
      sum += price
    end
    {user.name => sum}
  end



end