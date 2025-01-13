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
        book = Book.new(book_params)

        if book.save
          render json: book, status: :created
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

      def book_params
        params.require(:book).permit(:title, :author)
      end
    end
  end
end
