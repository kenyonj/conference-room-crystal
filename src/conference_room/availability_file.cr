class ConferenceRoom::AvailabilityFile
  def self.to_text
    new.to_text
  end

  def to_text
    String.build do |availabilities|
      all_calendars.each do |calendar|
        availabilities << "#{calendar.name} #{calendar.availability_code}\n"
      end
    end
  end

  private def all_calendars
    Calendar::CALENDAR_IDS.keys.map do |calendar_name|
      Calendar.new(calendar_name)
    end
  end
end
