require_relative "Validation"

module ConsoleInput
  def self.get_string_input(prompt)
    print prompt
    gets.chomp
  end

  def self.get_name_input
    loop do
      name = get_string_input("Введіть ваше ім'я: ")
      return name if name.match?(/\A[A-Za-z]+\z/)
      puts "Неправильне ім'я. Будь ласка, спробуйте ще раз."
    end
  end

  def self.get_integer_input(prompt)
    loop do
      input = get_string_input(prompt)
      return input.to_i if input.match?(/\A\d+\z/)
      puts "Неправильне значення. Будь ласка, введіть ціле число."
    end
  end

  def self.get_inn_input
    loop do
      inn = get_integer_input("Введіть ІНН: ")
      return inn if inn.to_s.length == 10
      puts "Неправильний ІНН. Будь ласка, введіть 10-значний ІНН."
    end
  end

  def self.get_date_input
    loop do
      date = get_string_input("Введіть дату (у форматі DD/MM/YYYY): ")
      return date if date.match?(/\A\d{2}\/\d{2}\/\d{4}\z/)
      puts "Неправильний формат дати. Будь ласка, введіть у форматі DD/MM/YYYY."
    end
  end
end
