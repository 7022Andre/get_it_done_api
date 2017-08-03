# Get-it-done API
A command-line operated API for a basic to-do list written in Ruby on Rails.

## Summary

- Ruby: 2.4.0
- Rails: 5.1.2

I wrote the code for this app to create simple to-do lists via an API. Main features:

- Token authentication via [Devise Token Auth](https://github.com/lynndylanhurley/devise_token_auth)
- Custom JSON string creation via [ActiveModelSerializers](https://github.com/rails-api/active_model_serializers)
- CRUD operations for users, lists, and to-do-items

This API was written using TDD with the help of the following gems:

- [Factory Girl Rails](https://github.com/thoughtbot/factory_girl_rails)
- [Faker](https://github.com/stympy/faker)
- [Ruby JSON Schema Validator](https://github.com/ruby-json-schema/json-schema)

### How to access the API

- Preferably use [Postman]() but [curl](https://github.com/curl/curl) works just as well
- Start Rails server `rails s`

#### Sign in

- POST localhost:3000/api/sign_in
- Enter your email and password as key/value in header
- Returns user data in body and authentication credentials in response header 
- **For all future requests attach `access-token`, `client` and `uid` keys/value pairs to request header**

#### Get all users

- GET localhost:3000/api/users
- 

### Project screenshots
