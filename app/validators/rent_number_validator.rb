class RentNumberValidator < ActiveModel::Validator
    def validate(record)
        #Rent.where("begin < ? && end > ?", record.end, record.begin).where.not(state: :unprocessed).sum(:number)
        return if record.number.nil? || record.begin.nil? || record.end.nil?
        sum = 0
        rents = Rent.all
        rents.each do |rent|
            sum += rent.number if(rent.begin < record.end && rent.end > record.begin && rent.state != "unprocessed")
        end
        if sum+record.number > record.item.number
            record.errors.add :base, "Erre az időpontra sajnos nincs elég a kívánt eszközből."
            record.errors.add :base, "A megadott napokra elérhető eszközök száma:"
            day = record.begin.to_date
            while(day <= record.end.to_date)
                sum = 0
                rents.each do |rent|
                    sum += rent.number if(rent.begin.to_date <= day && rent.end.to_date >= day && rent.state != "unprocessed")
                end
                record.errors.add :base, day.to_s + ": " + (record.item.number - sum).to_s + " darab"
                day += 1
            end
        end
    end
end
