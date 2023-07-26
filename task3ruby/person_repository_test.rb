#!/usr/bin/ruby
require 'test/unit'
require_relative '../task2ruby/person'
require_relative '../task2ruby/person-repository'  # Assuming the class is in the same directory

class PersonRepositoryTest < Test::Unit::TestCase
  def setup
    # Create some test persons for the repository
    @person1 = Person.new('John', 'Doe', 'AB1234567890', Date.new(1990, 1, 1))
    @person2 = Person.new('Alice', 'Smith', 'XY9876543210', Date.new(1985, 3, 15))

    # Create a PersonRepository instance and add test persons to it
    @repository = PersonRepository.new
    @repository.add_person(@person1)
    @repository.add_person(@person2)
  end

  # Test add_person method
  def test_add_person
    new_person = Person.new('Jane', 'Johnson', 'JK4567890123', Date.new(1995, 5, 20))

    # Adding a new person should increase the number of persons in the repository
    assert_equal(2, @repository.persons.length)
    @repository.add_person(new_person)
    assert_equal(3, @repository.persons.length)
  end

  # Test edit_person_by_inn method
  def test_edit_person_by_inn
    # Editing a person's data should update the person in the repository
    inn = 'AB1234567890'
    new_data = { first_name: 'Johnny', last_name: 'Doe-Johnson' }
    @repository.edit_person_by_inn(inn, new_data)

    edited_person = @repository.get_by_inn(inn)
    assert_equal('Johnny', edited_person.first_name)
    assert_equal('Doe-Johnson', edited_person.last_name)

    # Editing with an invalid INN should not change anything
    invalid_inn = 'INVALID'
    @repository.edit_person_by_inn(invalid_inn, new_data)
    assert_nil(@repository.get_by_inn(invalid_inn))
  end

  # Test delete_person_by_inn method
  def test_delete_person_by_inn
    inn = 'AB1234567890'
    # Deleting a person should remove the person from the repository
    assert_equal(2, @repository.persons.length)
    @repository.delete_person_by_inn(inn)
    assert_equal(1, @repository.persons.length)

    # Deleting with an invalid INN should not change anything
    invalid_inn = 'INVALID'
    @repository.delete_person_by_inn(invalid_inn)
    assert_equal(1, @repository.persons.length)
  end

  # Test get_by_inn method
  def test_get_by_inn
    inn = 'XY9876543210'
    # Retrieving a person by INN should return the correct person
    retrieved_person = @repository.get_by_inn(inn)
    assert_equal('Alice', retrieved_person.first_name)
    assert_equal('Smith', retrieved_person.last_name)

    # Retrieving with an invalid INN should return nil
    invalid_inn = 'INVALID'
    assert_nil(@repository.get_by_inn(invalid_inn))
  end

  # Test get_by_part_name method
  def test_get_by_part_name
    # Searching by part of the name should return matching persons
    matching_persons = @repository.get_by_part_name('ohn')
    assert_equal(1, matching_persons.length)
    assert_equal('John', matching_persons[0].first_name)

    # Searching with no matching name should return an empty array
    non_matching_persons = @repository.get_by_part_name('XYZ')
    assert_equal(0, non_matching_persons.length)
  end

  # Test get_by_date_range method
  def test_get_by_date_range
    # Searching within the date range should return matching persons
    start_date = '1980-01-01'
    end_date = '1995-12-31'
    matching_persons = @repository.get_by_date_range(start_date, end_date)
    assert_equal(2, matching_persons.length)

    # Searching outside the date range should return an empty array
    start_date = '2000-01-01'
    end_date = '2020-12-31'
    non_matching_persons = @repository.get_by_date_range(start_date, end_date)
    assert_equal(0, non_matching_persons.length)
  end
end

