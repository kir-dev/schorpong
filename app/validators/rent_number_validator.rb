class RentNumberValidator < ActiveModel::Validator
  def validate(record)
    #Rent.where("begin < ? && end > ?", record.end, record.begin).where.not(state: :unprocessed).sum(:number)
    return if record.number.nil? || record.begin.nil? || record.end.nil?

    rent_sum = rents.sum do | rent|
      return unless rent.begin < record.end
      return unless rent.end > record.begin
      return unless ['unprocessed', 'rejected'].include?(rent.state)
      rent.number
    end

    if rent_sum + record.number > record.item.number
      record.errors.add :base, "Erre az időpontra sajnos nincs elég a kívánt eszközből."
      record.errors.add :base, "A megadott napokra elérhető eszközök száma:"
      day = record.begin.to_date
      while (day <= record.end.to_date)
        sum = 0
        rents.each do |rent|
          sum += rent.number if (rent.begin.to_date <= day && rent.end.to_date >= day && rent.state != "unprocessed")
        end
        record.errors.add :base, day.to_s + ": " + (record.item.number - sum).to_s + " darab"
        day += 1
      end
    end
  end

  private

  def rents
    @rents ||= Rent.all
  end
end
