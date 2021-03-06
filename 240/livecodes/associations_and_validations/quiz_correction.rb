# Q1 - What's a relational database?

A set of tables linked to each other thanks to a system of primary keys / foreign keys.

# Q2 - What are the different "table relationships" you know?

One to many (1:N)
Many to many (N:N)
One to one (1:1) (less usual)

# Q3 - Consider this e-library service. An author, defined by his name have several books.
#      A book, defined by its title and publishing year, has one author only. What's this simple database scheme. Please draw it!

+---------+        +-----------------+
| authors |        |      books      |
+---------|        +-----------------+
| id      |---+    | id              |
| name    |   |    | title           |
+---------+   |    | publishing_year |
              +--->| author_id       |
                   +-----------------+

# Q4 - A user, defined by his email, can read several books. A book (e-book!!) can be read by several user.
#      We also want to keep track of reading dates. Improve your e-library DB scheme with relevant tables and relationships.

+---------+       +-----------------+       +----------+       +-------+
| authors |       |      books      |       | readings |       | users |
+---------|       +-----------------+       +----------+       +-------+
| id      |---+   | id              |---+   | id       |   +---| id    |
| name    |   |   | title           |   |   | date     |   |   | email |
+---------+   |   | publishing_year |   +---| book_id  |   |   +-------+
              +---| author_id       |       | user_id  |---+
                  +-----------------+       +----------+

# Q5 - What's the language to make queries to a database?

SQL: Structured Query Language

# Q6 - What's the simple query to get books written before 1985?

SELECT * FROM books WHERE publishing_year < 1985

# Q7 - What's the simple query to get the 3 most recent books written by Jules Verne?

SELECT * FROM books
JOIN authors ON authors.id = books.author_id
WHERE authors.name = 'Jules Verne'
ORBER BY publishing_year DESC
LIMIT 3;

# Q8 - What's the purpose of ActiveRecord?

ActiveRecord is a design pattern that maps your objects to a relational database.

This pattern is known as ORM for Object-Relational Mapping.

It's also the library (the gem) we used the last two days and we'll be using in Rails.

It abstracts SQL queries and comes with a set of simple methods and tools to manage your DB in ruby / CL.

Ask students what convention allows the mapping between a table in the DB and a ruby model.

# Q9 - What's a migration? How do you run a migration?

A script modifying the schema of the database.

rake db:migrate

# Q10 - Complete migrations to create your e-library database

# Authors table
class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.timestamps
    end
  end
end

# Books table
class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :publishing_year
      t.references :author, foreign_key: true
      t.timestamps
    end
  end
end

# Users table
class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.timestamps
    end
  end
end

# Readings table
class CreateReadings < ActiveRecord::Migration[5.1]
  def change
    create_table :readings do |t|
      t.datetime :date
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.timestamps
    end
  end
end

# Q11 - Write a migration to add a category column to the books table.

class AddCategoryToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :category, :string
  end
end

# Q12 - Define an ActiveRecord model for each table of your DB. Add the ActiveRecord associations between models.

# Author
class Author < ActiveRecord::Base
  has_many :books
  validates :name, presence: true
end

# Book
class Book < ActiveRecord::Base
  belongs_to :author
  has_many :readings
  has_many :users, through: :readings
  validates :title, presence: true
  validates :publishing_year, numericality: { only_integer: true}
end

# User
class User < ActiveRecord::Base
  has_many :readings
  has_many :books, through: :readings
  validates :email, format: { with: /\A\w+@{1}\w+\.\w{2,3}(\.\w{2})?\z/ }
end

# Reading
class Reading < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
end

# Q13 - Complete the following code using the relevant ActiveRecord methods.

# 1. Add your favorite author to the DB

Author.create(name: "fave author")

# 2. Get all authors

Author.all

# 3. Get author with id=8

Author.find(8)

# 4. Get author with name="Jules Verne", store it in a variable: jules

jules = Author.find_by(name: "Jules Verne")

# 5. Get Jules Verne's books

jules.books

# 6. Create a new book "20000 Leagues under the Seas", it's missing in DB.
#    Store it in a variable: twenty_thousand

twenty_thousand = Book.new(title: "20000 Leagues under the Seas")

# 7. Add Jules Verne as this book's author

twenty_thousand.author = jules

# 8. Now save this book in the DB!

twenty_thousand.save!

# Q14 - Add validations of your choice to the Author class. Can we save an object in DB if its validations do not pass?

















