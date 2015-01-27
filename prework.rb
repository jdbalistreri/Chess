
class Employee

  def initialize(title, salary, boss)
    @title, @salary, @boss = title, salary, boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end

  def total_salaries_below
    @salary
  end

end


class Manager < Employee

  def initialize(title, salary, boss, employee_list)
    @employee_list = employee_list

    super(title, salary, boss)
  end

  def bonus(multiplier)
     total_salaries_below * multiplier
  end

  def total_salaries_below
    total_salaries = @salary

    @employee_list.each do |employee|
      total_salaries += employee.total_salaries_below
    end

    total_salaries
  end

end
