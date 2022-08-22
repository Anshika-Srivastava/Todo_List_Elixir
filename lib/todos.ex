defmodule Todos do
  def hello_world do
    IO.puts("Hello World")
    ["apples","bananas","guavas"]
    IO.gets("Please enter an input: ")
  end

  def create_todos do
    #old code: Not so nice
    #num_of_tasks=IO.gets("Enter the number of todos you want to add: ")
    #{num_of_tasks, _q}=Integer.parse(num_of_tasks)
    #num_of_tasks

    #new code
    #The pipe operator |> passes the result of an expression as the first parameter of another expression.
    {num_of_tasks, _q} = IO.gets("Enter the number of todos you want to add: ") |> Integer.parse()

    for _ <- 1..num_of_tasks do
      IO.gets("Enter task: ") |> String.trim()
    end
  end

  def temp_todos do
    ["eat an apple", "read a book", "make elixir projects", "elixir exercises"]
  end

  def add_todo(tasks,task) do
    List.insert_at(tasks, -1, task)
  end

  def complete_todo(tasks,task) do
    if contains?(tasks,task) do
      List.delete(tasks,task)
    else
      :not_found_error
    end
  end

  def keyword_search(tasks,word) do
    for task <- tasks, String.contains?(task,word) do
      task
    end
  end
  def contains?(tasks, task) do
    Enum.member?(tasks,task)
  end

  def random_tasks(tasks) do
    [task]=Enum.take_random(tasks, 1)
    task
  end

  def save(tasks, filename) do
    #invoking erlang code
    #converting our list so that it can be written to our file system
    binary = :erlang.term_to_binary(tasks)
    File.write(filename,binary)
  end

  def read(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File does not exists"
    end
    #{_status, binary} = File.read(filename)
    #:erlang.binary_to_term(binary)
  end
end
