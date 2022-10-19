# Validators are instantiated once, instance variables persist between validations, might cause bugs
class RentNumberValidator < ActiveModel::Validator
  def validate(rent)
    active_rents = active_rents(rent)
    intervals = intervals(rent, active_rents)
    sum_items_in_intervals = sum_items_in_intervals(intervals, active_rents)

    sum_items_in_intervals.each do |interval, sum_items|
      available_item_number = rent.item.number - sum_items
      if available_item_number < rent.number
        rent.errors.add :base, "A kiválasztott időszakban (#{(interval)}) csak #{available_item_number} darab #{rent.item.name} elérhető."
      end
    end
  end

  private

  def formatted_interval(interval)
    "#{formatted_date(interval.begin)} - #{formatted_date(interval.end)}"
  end

  def formatted_date(date)
    date.strftime("%Y-%m-%d %H:%M")
  end
  def sum_items_in_intervals(intervals, active_rents)
    result = {}
    intervals.each do |interval|
      sum_item_number = 0
      active_rents.each do |active_rent|
        if overlaps?(interval, active_rent.interval)
          sum_item_number += active_rent.number
        end
      end
      result[formatted_interval(interval)] = sum_item_number
    end
    result
  end

  def overlaps?(range1, range2)
    !(range2.end <= range1.begin || range1.end <= range2.begin)
  end

  def intervals(rent, active_rents)
    time_points = active_rents.map { |active_rent| [active_rent.begin, active_rent.end] }.flatten
    time_points = time_points.select { |time_point| time_point.between?(rent.begin, rent.end) }
    time_points.push(rent.begin, rent.end)
    time_points = time_points.uniq.sort
    intervals = time_points.map.with_index do |time_point, index|
      next_time_point = time_points[index + 1]
      next unless next_time_point

      (time_point..next_time_point)
    end.compact
    intervals
  end

  def active_rents(rent)
    Rent.includes(:item)
        .where(item: rent.item)
        .where(state: [:approved, :taken])
        .where.not('rents.end <= :begin or :end <= rents.begin',
                   { begin: rent.begin, end: rent.end })
  end
end
