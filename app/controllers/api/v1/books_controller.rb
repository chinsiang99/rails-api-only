module Api
  module V1
    class BooksController < ApplicationController
      rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      def index
        # render json: Book.all
        books = Book.all

        # Rails.logger.info "First book details: #{books[0].inspect} yoyoyo"

        render json: BooksRepresenter.new(books).as_json()
      end

      def create
        # some logic here
        # book = Book.create(title: "Harry Potter 1", author: "Chin Siang")
        # book = Book.new(title: params[:title]", author: params[:author])

        # note that below binding.irb is very suitable for debugging, it can be used for unit test debugging as well, we can see it as a breakpoint here
        # binding.irb

        author = Author.create!(author_params)
        book = Book.new(book_params.merge(author_id: author.id))

        if book.save
          # book.reload
          # render json: book, status: :created
          render json: BookRepresenter.new(book).as_json(), status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def destroy
        Book.find(params[:id]).destroy!

        head :no_content

        # below is for specific function
        # rescue ActiveRecord::RecordNotDestroyed
        #   render json: {}, status: :unprocessable_entity
        # rescue ActiveRecord::RecordNotFound
        #   render json: {}, status: :not_found
      end

      private

      def author_params
        params.require(:author).permit(:first_name, :last_name, :age)
      end

      def book_params
        params.require(:book).permit(:title)
      end
    end
  end
end
