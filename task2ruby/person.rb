require_relative "console-input"

class Person
  include ConsoleInput
  include Validation

  attr_reader :first_name, :last_name, :inn, :birth_date

  def initialize(first_name, last_name, inn, birth_date)
    @first_name = first_name
    @last_name = last_name
    @inn = inn
    @birth_date = birth_date
  end

  def first_name=(new_first_name)
    validate_name(new_first_name)
    @first_name = new_first_name
  end

  def last_name=(new_last_name)
    validate_name(new_last_name)
    @last_name = new_last_name
  end

  def inn=(new_inn)
    validate_inn(new_inn)
    @inn = new_inn
  end

  def birth_date=(new_birth_date)
    validate_birth_date(new_birth_date)
    @birth_date = new_birth_date
  end

  private

  def validate_name(name)
    raise ArgumentError, "Invalid #{name} format" unless valid_name?(name)
  end

  def validate_inn(inn)
    raise ArgumentError, "Invalid INN" unless valid_inn?(inn)
  end

  def validate_birth_date(birth_date)
    raise ArgumentError, "Invalid Birth Date" unless valid_date_format?(birth_date)
    value = Date.parse(birth_date)
    raise ArgumentError, "Birth Date cannot be in the future" unless after_date?(value)
  end
end
