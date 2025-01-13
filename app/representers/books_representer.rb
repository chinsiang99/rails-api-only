class BooksRepresenter
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
          author_name: "#{book.author&.first_name} #{book.author&.last_name}",
          author_age: book.author&.age
        }
      end
    end

    private

    attr_reader :books
end
