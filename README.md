# Picturepository

## What is this?
A GraphQL API for Shopify's backend challenge. A image repository where you are able to purchase, add, and search for photos!

## How to use?
- Clone/download the repo 
- Make sure a postgres db is running
- Run `bundle install` to install all gems from the `Gemfile`
- Run `rails db:drop` then `rails db:create` then `rails db:migrate` to create the database tables
- To start the server run the command `rails s`
- Access the server on `localhost:3000` and `localhost:3000/graphiql` to find the GraphiQL interface

## Data models
- image
- hash_tag
- image_hash_tag
- purchase
- user

## Mutations
- `create_image`
    - Allows a user to create a image.
- `delete_image`
    - Allows a user to delete a image.
- `update_image`
    - Allows a user to update a image.
- `sign_up_user`
    - Creates a user.
- `sign_in_user`
    - Allows a user to login.
- `update_user`
    - Allows the user to update their account.
- `create_purchase`
    - Allows a user to purchase a image.

## Queries
- `search_images`
    - Allows a user to search for an images. Pagination can be done by adding any of these`first:Int`, `last:Int`, `after:String`, `before:String` to the parameters
- `images`
    - Allows a user to get all images. Pagination can be done by adding any of these`first:Int`, `last:Int`, `after:String`, `before:String` to the parameters
- `image`
    - Allows a user to get a specific image based on ID.
- `hash_tag`
    - Allows a user to get all hashtags. Pagination can be done by adding any of these`first:Int`, `last:Int`, `after:String`, `before:String` to the parameters
- `users`
    - Allows a user to get all users. Pagination can be done by adding any of these`first:Int`, `last:Int`, `after:String`, `before:String` to the parameters
- `user`
    - Allows a user to get a specific user based on user ID
- `purchase`
    - Allows a user to get a specific purchase based on user ID


