require "date"

class Todo
  def initialize(text, due_date, completed)
    @text = text
    @due_date = due_date
    @completed = completed
  end

  def is_due?
    @due_date == Date.today
  end

  def is_overdue?
    @due_date < Date.today
  end

  def is_duelater?
    @due_date > Date.today
  end

  def to_displayable_string
    if (@completed == true)
      @flag = " X "
    else
      @flag = "   "
    end
    if (is_due? == false)
      @printdate = @due_date
    end

    out1 = "[#{@flag}] #{@text} #{@printdate}"
    return out1
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  def add(add_todo)
    @todos.push(add_todo)
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.is_overdue? })
  end

  def due_today
    TodosList.new(@todos.filter { |todo| todo.is_due? })
  end

  def due_later
    TodosList.new(@todos.filter { |todo| todo.is_duelater? })
  end

  def to_displayable_list
    @todos.map { |todo| puts todo.to_displayable_string }.join("\n")
  end
end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service Your vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
