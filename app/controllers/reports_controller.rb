class ReportsController < ApplicationController

  def current_members
    current_subscribers = []
    User.all.map do |user|
      subscribed = user.subscription_events.map { |event| event.event_type }.last
      current_subscribers << user unless subscribed == 'unsubscribed'
    end
    @current_subscribers = current_subscribers
  end
end