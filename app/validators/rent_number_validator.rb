# Validators are instantiated once, instance variables persist between validations, might cause bugs
class RentNumberValidator < ActiveModel::Validator
  def validate(record)
    item = record.item
    active_rents = active_rents(record)
    rent_days = rent_days(active_rents)
    rents_by_item = rents_by_item(rent_days, active_rents)

    record.days.each do |day|
      rent_number_for_day = rents_by_item.dig(day) || 0
      if rent_number_for_day + record.number > item.number
        available_item_number = item.number - rent_number_for_day
        record.errors.add :base, "A kiválasztott napon(#{day}) csak #{available_item_number} darab #{item.name} elérhető."
      end
    end
  end

  private

  # hash[rent_day] = sum taken out amount item (per day)
  def rents_by_item(rent_days, active_rents)
    result = {}
    rent_days.each do |rent_date|
      result[rent_date] = 0 if result[rent_date].nil?
      active_rents.each do |active_rent|
        result[rent_date] += active_rent.number
      end
    end
    result
  end

  def rent_days(active_rents)
    active_rents.map(&:days).flatten.uniq.sort
  end

  def active_rents(record)
    Rent.includes(:item)
        .where(item: record.item)
        .where(state: [:approved, :taken])
        .where.not('rents.end <= :begin or :end <= rents.begin',
                   { begin: record.begin, end: record.end })
  end
end
