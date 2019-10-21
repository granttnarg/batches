class Recipe
  attr_reader :name, :description, :prep_time, :done

  def initialize(name, description, prep_time, done = false)
    @name = name
    @description = description
    @prep_time = prep_time
    @done = done
  end

  def change_marking
    @done = !@done
  end
end
