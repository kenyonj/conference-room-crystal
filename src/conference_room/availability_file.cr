class ConferenceRoom::AvailabilityFile
  def self.to_text
    new.to_text
  end

  def to_text
    String.build do |availabilities|
      Calendar.all.each do |calendar|
        availabilities << "#{calendar.name} #{calendar.availability_code}\n"
      end
    end
  end
end
