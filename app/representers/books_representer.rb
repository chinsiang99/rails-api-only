class BooksRepresenter
    # please note that we use representer here because of use cases for very specific, custom serialization needs
    # normally the convention way is to go with ActiveModel::Serializer
    # Gemfile
    # gem 'active_model_serializers'
    # below is the example code of it
    # Define a serializer class for Book using ActiveModel::Serializer
    # This class is responsible for defining how Book objects are represented in JSON
    # class BookSerializer < ActiveModel::Serializer
    #   # The 'attributes' method specifies which fields will be included in the serialized output.
    #   # These are the attributes of the Book model we want to include in the JSON response.
    #   attributes :id, :title, :author_first_name, :author_last_name, :author_name, :author_age

    #   # Define a custom method for 'author_name' to combine last and first names of the author
    #   # This method will be used to include the full author name in the JSON response
    #   def author_name
    #     # We are using the safe navigation operator (&.) to ensure that if 'author' is nil, it won't throw an error.
    #     # The 'author' object might be nil if a book does not have an associated author.
    #     # Combining the author's last name and first name into a single string, with a space in between.
    #     "#{object.author&.last_name} #{object.author&.first_name}"
    #   end
    # end

    # # In your controller:
    # def index
    #   # Retrieve all Book records from the database.
    #   # This will get an ActiveRecord relation containing all books in the database.
    #   books = Book.all

    #   # The 'render' method is used to render the JSON response.
    #   # We specify the 'books' variable to be rendered as JSON.
    #   # 'each_serializer' tells Rails to use the 'BookSerializer' for each item in the 'books' array.
    #   # This will serialize each book using the BookSerializer and return it in the response.
    #   render json: books, each_serializer: BookSerializer
    # end

    def initialize(books)
      @books = books
    end

    def as_json
      books.map do |book|
        {
          id: book.id,
          title: book.title,
          author_first_name: book.author&.first_name.to_s, # use .to_s will turn nil into empty string
          author_last_name: book.author&.last_name.to_s, # we have &. to indicate if doesnt have author then it will return nil
          # author_name: "#{book.author&.first_name} #{book.author&.last_name}",
          author_name: author_name(book),
          author_age: book.author&.age
        }
      end
    end

    private

    attr_reader :books

    def author_name(book)
      "#{book.author&.first_name} #{book.author&.last_name}"
    end
end
