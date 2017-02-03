class ConferenceRoom::AvailabilityFile
  def self.to_text
    new.to_text
  end

  def to_text
    String.build do |availabilities|
      Calendar.all.each do |calendar|
        availabilities << "#{calendar.name}"
        availabilities << " #{calendar.availability_code}"
        availabilities << " #{calendar.minutes_until_state_change}\n"
      end

    end
  end
end
