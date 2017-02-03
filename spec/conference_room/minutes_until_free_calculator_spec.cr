require "../../spec_helper"

describe ConferenceRoom::MinutesUntilFreeCalculator do
  describe "when next event starts more than 5 minutes after current event ends" do
    it "returns the minutes between now and the end time of the current event" do
      current_event = ConferenceRoom::CalendarEvent.new(1.minute.ago, 5.minutes.from_now)
      next_event = ConferenceRoom::CalendarEvent.new(15.minutes.from_now, 20.minutes.from_now)
      events = [current_event, next_event]

      calculator = ConferenceRoom::MinutesUntilFreeCalculator.new(events)

      calculator.minutes_until_free.should eq 5
    end
  end

  describe "when next event starts less than 5 minutes after current event ends" do
    it "returns the amount of minutes until the next event ends" do
      current_event = ConferenceRoom::CalendarEvent.new(1.minute.ago, 5.minutes.from_now)
      next_event = ConferenceRoom::CalendarEvent.new(7.minutes.from_now, 20.minutes.from_now)
      events = [current_event, next_event]

      calculator = ConferenceRoom::MinutesUntilFreeCalculator.new(events)

      calculator.minutes_until_free.should eq 20
    end
  end

  describe "when the next event starts right after the current event and there
  is an event afterward that is more than 5 minutes after" do
    it "returns the amount of minutes until the beginning of the free time" do
      current_event = ConferenceRoom::CalendarEvent.new(1.minute.ago, 5.minutes.from_now)
      next_event = ConferenceRoom::CalendarEvent.new(5.minutes.from_now, 20.minutes.from_now)
      next_next_event = ConferenceRoom::CalendarEvent.new(26.minutes.from_now,
                                                          30.minutes.from_now)
      events = [current_event, next_event, next_next_event]

      calculator = ConferenceRoom::MinutesUntilFreeCalculator.new(events)

      calculator.minutes_until_free.should eq 20
    end
  end
end
