require_relative "person"

class PersonRepository
  attr_reader :persons

  def initialize
    @persons = []
  end

  def add_person(person)
    @persons << person
  end

  def edit_person_by_inn(inn, new_data)
    person = get_by_inn(inn)
    return unless person

    person.first_name = new_data[:first_name] if new_data.key?(:first_name)
    person.last_name = new_data[:last_name] if new_data.key?(:last_name)
    person.birth_date = new_data[:birth_date] if new_data.key?(:birth_date)
  end

  def delete_person_by_inn(inn)
    person = get_by_inn(inn)
    return unless person

    @persons.delete(person)
  end

  def get_by_inn(inn)
    @persons.find { |person| person.inn == inn }
  end

  def get_by_part_name(name)
    @persons.select { |person| person.first_name.include?(name) || person.last_name.include?(name) }
  end

  def get_by_date_range(start_date, end_date)
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)

    @persons.select { |person| person.birth_date >= start_date && person.birth_date <= end_date }
  end
end
