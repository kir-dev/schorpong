class RentNumberValidator < ActiveModel::Validator
    def validate(record)
        #Rent.where("begin < ? && end > ?", record.end, record.begin).where.not(state: :unprocessed).sum(:number)
        return if record.number.nil?
        sum = 0
        rents = Rent.all
        rents.each do |rent|
            sum += rent.number if(rent.begin < record.end && rent.end > record.begin && rent.state != "unprocessed")
        end
        if sum+record.number > record.item.number
            record.errors.add :base, "Erre az időpontra sajnos elfogyott a kívánt eszköz."
        end
    end
end
