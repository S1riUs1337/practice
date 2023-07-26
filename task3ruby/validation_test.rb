#!/usr/bin/ruby
require 'test/unit'
require 'date'
require_relative '../task1ruby/task_1ruby'

class ValidationTest < Test::Unit::TestCase
  include Validation


  ['John-Doe', 'Alice'].each_with_index do |name, index|
    define_method("test_valid_name_#{index + 1}") do
      assert(valid_name?(name))
    end
  end

  ['John 123', 'aA', 'A'*41, 'Michael-', 'A-b', 'petro'].each_with_index do |name, index|
    define_method("test_invalid_name_#{index + 1}") do
      assert_false(valid_name?(name))
    end
  end

  ['AB1234567890', 'XY9876543210'].each_with_index do |inn, index|
    define_method("test_valid_inn_#{index + 1}") do
      assert(valid_inn?(inn))
    end
  end

  ['AB123456789', 'AB12345678901', 'AB12X4567890', 'AB1234567890X'].each_with_index do |inn, index|
    define_method("test_invalid_inn_#{index + 1}") do
      assert_false(valid_inn?(inn))
    end
  end

  # Test after_date? method
  def test_after_date
    future_date = Date.today + 1
    past_date = Date.today - 1

    assert(after_date?(past_date))
    assert(!after_date?(future_date))
  end
end

