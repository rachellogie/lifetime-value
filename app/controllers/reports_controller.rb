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
        subscription_dates = user.subscription_events.map { |sub| {sub.date => sub.price_per_month_in_cents} }
        subscription_dates = subscription_dates.reduce Hash.new, :merge
        start_date = user.subscription_events.first.date
        end_date = Date.today.beginning_of_month
        months_list = [start_date]
        next_date = start_date
        until next_date == end_date
          next_date = (next_date + 33).beginning_of_month
          months_list << next_date
        end
        sum = 0
        price = user.subscription_events.first.price_per_month_in_cents
        months_list.each do |month|
          if subscription_dates.has_key? month
            price = subscription_dates[month]
          end
          sum += price
        end
        lifetime_values << {user.name => sum}
      end
      @lifetime_values = lifetime_values
    end
  end


end