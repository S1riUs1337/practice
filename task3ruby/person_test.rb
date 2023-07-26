#!/usr/bin/ruby
require 'test/unit'
require 'date'
require_relative '../task2ruby/person'

class PersonTest < Test::Unit::TestCase
  def setup
    # Sample data for testing
    @valid_first_name = 'John'
    @valid_last_name = 'Doe'
    @valid_inn = 'AB1234567890'
    @valid_birth_date = Date.today.to_s

    # Create a valid person for testing
    @person = Person.new(@valid_first_name, @valid_last_name, @valid_inn, @valid_birth_date)
  end

  # Test initialize method and attribute accessors
  def test_initialize_and_attributes
    assert_equal(@valid_first_name, @person.first_name)
    assert_equal(@valid_last_name, @person.last_name)
    assert_equal(@valid_inn, @person.inn)
    assert_equal(@valid_birth_date, @person.birth_date)
  end

  # Test first_name= method with valid and invalid data
  def test_first_name_assignment
    new_valid_name = 'Jane'
    @person.first_name = new_valid_name
    assert_equal(new_valid_name, @person.first_name)

    # Attempt to set an invalid name, should raise ArgumentError
    assert_raise(ArgumentError) { @person.first_name = 'John 123' }
  end

  # Test last_name= method with valid and invalid data
  def test_last_name_assignment
    new_valid_name = 'Johnson'
    @person.last_name = new_valid_name
    assert_equal(new_valid_name, @person.last_name)

    # Attempt to set an invalid name, should raise ArgumentError
    assert_raise(ArgumentError) { @person.last_name = 'Doe-' }
  end

  # Test inn= method with valid and invalid data
  def test_inn_assignment
    new_valid_inn = 'XY9876543210'
    @person.inn = new_valid_inn
    assert_equal(new_valid_inn, @person.inn)

    # Attempt to set an invalid INN, should raise ArgumentError
    assert_raise(ArgumentError) { @person.inn = 'INVALID' }
  end

end
