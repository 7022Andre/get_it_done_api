# Get-it-done API
A command-line operated API for a basic to-do list written in Ruby on Rails.

## Summary

- Ruby: 2.4.0
- Rails: 5.1.2

This API allows users to create public and private to-do lists. Main features:

- Token authentication via [Devise Token Auth](https://github.com/lynndylanhurley/devise_token_auth)
- Custom JSON string creation via [ActiveModelSerializers](https://github.com/rails-api/active_model_serializers)
- CRUD operations for users, lists, and to-do items
- Private/Public lists

This API was written using TDD with the help of the following gems:

- [Factory Girl Rails](https://github.com/thoughtbot/factory_girl_rails)
- [Faker](https://github.com/stympy/faker)
- [Ruby JSON Schema Validator](https://github.com/ruby-json-schema/json-schema)

## How to access the API

1. Clone repo
2. Start Rails server `rails s`
3. Preferably use [Postman](https://www.getpostman.com/apps) but [curl](https://github.com/curl/curl) works just as well to make requests

### Sign in

- `POST localhost:3000/api/sign_in`
- Enter your email and password as key/value in request header.
- Responds with user data in body and authentication credentials in header.
- **For all future requests attach `access-token`, `client` and `uid` keys/value pairs to request header.**

![api_sign_in.gif](https://s1.postimg.org/cml1pegof/api_sign_in.gif "Sign in")


---
### User operations

#### Get all users

- `GET localhost:3000/api/users`

![api_get_all_users.gif](https://s2.postimg.org/ilv38j47t/api_get_all_users.gif "Get all users")

#### Create user

- `POST localhost:3000/api/users`
- Enter new user's `email` and `password` in body using these keys: `user[email]` and `user[password]`.

![api_create_user.gif](https://s2.postimg.org/yqkdefm15/api_create_user.gif "Create user")

#### Delete user

- `DELETE localhost:3000/api/users/{user.id}`

![api_delete_user.gif](https://s1.postimg.org/ybinlgelr/api_delete_user.gif "Delete user")


---
### List operations

#### Get list of specific user

- `GET localhost:3000/api/users/{user.id}/lists`
- **Returns only public lists of specific user if requesting user is not the list owner.**

![api_get_lists.gif](https://s2.postimg.org/mhqghh055/api_get_lists.gif "Get lists")

#### Create list

- `POST localhost:3000/api/users/{user.id}/lists`
- Enter new list's `title` and `public` attribute in body using these keys: `list[title]` and `list[public]`.

![api_create_list.gif](https://s1.postimg.org/fic77qhlr/api_create_list.gif "Create list")

#### Update list

- `PUT localhost:3000/api/users/{user.id}/lists/{list.id}`
- Enter updated list `title` and/or `public` attribute in body using these keys: `list[title]` and `list[public]`.

![api_update_list.gif](https://s2.postimg.org/esileoj61/api_update_list.gif "Update list")

#### Delete list

- `DELETE localhost:3000/api/users/{user.id}/lists/{list.id}`

![api_delete_list.gif](https://s1.postimg.org/661gdtobj/api_delete_list.gif "Delete list")


---
### Item operations

#### Get items of list

- `GET localhost:3000/api/lists/{list.id}/items`

![api_get_items.gif](https://s2.postimg.org/ltme9wsrd/api_get_items.gif "Get items")

#### Create item

- `POST localhost:3000/api/lists/{list.id}/items`
- Enter new item's `body` attribute in body using this key: `item[body]`.

![api_create_item.gif](https://s1.postimg.org/wf2jhtgkf/api_create_item.gif "Create item")

#### Update item

- `PUT localhost:3000/api/lists/{list.id}/items/{item.id}`
- Enter updated item `body` and `completed` attribute in body using these keys: `item[body]` and `item[completed]`.

![api_update_item.gif](https://s1.postimg.org/3w52wde4f/api_update_item.gif "Update item")

#### Delete item

- `DELETE localhost:3000/api/items/{item.id}`

![api_delete_item.gif](https://s1.postimg.org/89gwcpcvz/api_delete_item.gif "Delete item")
