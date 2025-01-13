# require 'rails_helper'

# describe 'Books API', type: :request do
#     it 'returns all books' do
#       get '/api/v1/books'

#       expect(response).to have_http_status(:success)
#       expect(JSON.parse(response.body).size).to eq(2)
#     end
# end

require 'rails_helper'

# RSpec.describe Api::V1::BooksController, type: :controller do
# Use FactoryBot to create a sample book
# let!(:book) { create(:book) } # This will create a Book with title "Sample Book" and author "Sample Author"
# let(:valid_attributes) { { book: { title: "The Hobbit", author: "J.R.R. Tolkien" } } }
# let(:invalid_attributes) { { book: { title: "", author: "" } } }


describe 'Books API', type: :request do
  describe 'GET /api/v1/books' do
    it 'returns a list of books' do
      FactoryBot.create(:book, title: 'mock book title', author: 'mock author')
      FactoryBot.create(:book, title: 'mock book title 2', author: 'mock author 2')
      get '/api/v1/books'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2) # As we have two books created
    end
  end

  describe 'POST /api/v1/books' do
    context 'with valid parameters' do
      it 'creates a new book and returns a successful response' do
        expect {
          post '/api/v1/books', params: { book: { title: 'mock title', author: 'mock author' } }
        }.to change { Book.count }.from(0).to(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['title']).to eq('mock title')
        expect(JSON.parse(response.body)['author']).to eq('mock author')
      end
    end

    context 'with title and author missing' do
      it 'should return unprocessable entity status' do
        post '/api/v1/books', params: { book: {} }

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with title missing' do
      it 'should return unprocessable entity status' do
        post '/api/v1/books', params: { book: { author: 'mock author' } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with author missing' do
      it 'should return bad request status' do
        post '/api/v1/books', params: { book: { title: 'mock title' } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'DELETE /api/v1/books/:id' do
      context 'if book is found' do
        it 'should delete a book' do
          FactoryBot.create(:book, title: 'mock book title', author: 'mock author')
          delete '/api/v1/books/1'
          expect(response).to have_http_status(:no_content)
        end
      end

      context 'if book is not found' do
        it 'should return not found status' do
          delete '/api/v1/books/3'
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    # context 'with author missing' do
    #   it 'should return bad request status' do
    #     post '/api/v1/books', params: { book: { title: 'mock title' } }

    #     expect(response).to have_http_status(:bad_request)
    #   end
    # end
    # it 'returns a list of books' do
    #   FactoryBot.create(:book, title: 'mock book title', author: 'mock author')
    #   FactoryBot.create(:book, title: 'mock book title 2', author: 'mock author 2')
    #   get '/api/v1/books'
    #   expect(response).to have_http_status(:success)
    #   expect(JSON.parse(response.body).size).to eq(2) # As we have two books created
    # end
  end
end
# describe 'POST #create' do
#   context 'with valid parameters' do
#     it 'creates a new book and returns a successful response' do
#       expect {
#         post :create, params: valid_attributes
#       }.to change(Book, :count).by(1)

#       expect(response).to have_http_status(:created)
#       expect(JSON.parse(response.body)['title']).to eq('The Hobbit')
#       expect(JSON.parse(response.body)['author']).to eq('J.R.R. Tolkien')
#     end
#   end

#   context 'with invalid parameters' do
#     it 'does not create a book and returns an error response' do
#       post :create, params: invalid_attributes

#       expect(response).to have_http_status(:unprocessable_entity)
#       expect(JSON.parse(response.body)).to include("title", "author")
#     end
#   end
# end

# describe 'DELETE #destroy' do
#   context 'with a valid book ID' do
#     it 'deletes the book and returns no content' do
#       expect {
#         delete :destroy, params: { id: book.id }
#       }.to change(Book, :count).by(-1)

#       expect(response).to have_http_status(:no_content)
#     end
#   end

#   context 'with an invalid book ID' do
#     it 'returns a not found error' do
#       expect {
#         delete :destroy, params: { id: 'invalid_id' }
#       }.to raise_error(ActiveRecord::RecordNotFound)

#       expect(response).to have_http_status(:not_found)
#     end
#   end
# end
# end
