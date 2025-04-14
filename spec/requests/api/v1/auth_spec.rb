require 'swagger_helper'

RSpec.describe 'Authentication API', type: :request do
  path '/api/v1/auth/sign_up' do
    post 'Creates a user' do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string },
              password_confirmation: { type: :string }
            },
            required: ['email', 'password', 'password_confirmation']
          }
        },
        required: ['user']
      }

      response '201', 'user created' do
        let(:user) { { user: { email: 'test@example.com', password: 'password', password_confirmation: 'password' } } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { user: { email: 'invalid', password: 'short', password_confirmation: 'mismatch' } } }
        run_test!
      end
    end
  end

  path '/api/v1/auth/sign_in' do
    post 'Signs in a user' do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            },
            required: ['email', 'password']
          }
        },
        required: ['user']
      }

      response '200', 'user signed in' do
        let(:user) { { user: { email: 'test@example.com', password: 'password' } } }
        run_test!
      end

      response '401', 'invalid credentials' do
        let(:user) { { user: { email: 'test@example.com', password: 'wrong' } } }
        run_test!
      end
    end
  end

  path '/api/v1/auth/sign_out' do
    delete 'Signs out a user' do
      tags 'Authentication'
      security [Bearer: {}]

      response '200', 'user signed out' do
        let(:Authorization) { 'Bearer token' }
        run_test!
      end

      response '401', 'user not signed in' do
        let(:Authorization) { 'Bearer invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/auth/me' do
    get 'Gets current user profile' do
      tags 'Authentication'
      security [Bearer: {}]

      response '200', 'user profile' do
        let(:Authorization) { 'Bearer token' }
        run_test!
      end

      response '401', 'user not signed in' do
        let(:Authorization) { 'Bearer invalid' }
        run_test!
      end
    end
  end
end
