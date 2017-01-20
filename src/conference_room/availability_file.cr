class ConferenceRoom::AvailabilityFile
  def self.update
    new.update
  end

  def update
    write_updated_calendar_availabilities
  end

  private def write_updated_calendar_availabilities
    rows = String.build do |rows|
      all_calendars.each do |calendar|
        rows << "#{calendar.name} #{calendar.busy_code}\n"
      end
    end

    File.write("availabilities", rows)
  end

  private def all_calendars
    Calendar::CALENDAR_IDS.keys.map do |calendar_name|
      Calendar.new(calendar_name)
    end
  end
end
