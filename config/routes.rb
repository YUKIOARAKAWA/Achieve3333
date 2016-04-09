# == Route Map
#
#                    Prefix Verb     URI Pattern                            Controller#Action
#    about_conpany_overview GET      /about/conpany_overview(.:format)      about#conpany_overview
#          new_user_session GET      /users/sign_in(.:format)               users/sessions#new
#              user_session POST     /users/sign_in(.:format)               users/sessions#create
#      destroy_user_session DELETE   /users/sign_out(.:format)              users/sessions#destroy
#   user_omniauth_authorize GET|POST /users/auth/:provider(.:format)        users/omniauth_callbacks#passthru {:provider=>/facebook|twitter/}
#    user_omniauth_callback GET|POST /users/auth/:action/callback(.:format) users/omniauth_callbacks#(?-mix:facebook|twitter)
#             user_password POST     /users/password(.:format)              users/passwords#create
#         new_user_password GET      /users/password/new(.:format)          users/passwords#new
#        edit_user_password GET      /users/password/edit(.:format)         users/passwords#edit
#                           PATCH    /users/password(.:format)              users/passwords#update
#                           PUT      /users/password(.:format)              users/passwords#update
#  cancel_user_registration GET      /users/cancel(.:format)                users/registrations#cancel
#         user_registration POST     /users(.:format)                       users/registrations#create
#     new_user_registration GET      /users/sign_up(.:format)               users/registrations#new
#    edit_user_registration GET      /users/edit(.:format)                  users/registrations#edit
#                           PATCH    /users(.:format)                       users/registrations#update
#                           PUT      /users(.:format)                       users/registrations#update
#                           DELETE   /users(.:format)                       users/registrations#destroy
#         user_confirmation POST     /users/confirmation(.:format)          devise/confirmations#create
#     new_user_confirmation GET      /users/confirmation/new(.:format)      devise/confirmations#new
#                           GET      /users/confirmation(.:format)          devise/confirmations#show
#                     users GET      /users(.:format)                       users#index
#                      user GET      /users/:id(.:format)                   users#show
#                      root GET      /                                      top#index
#                   inquiry GET      /inquiry(.:format)                     inquiry#index
#           inquiry_confirm POST     /inquiry/confirm(.:format)             inquiry#confirm
#                           POST     /inquiry(.:format)                     inquiry#create
#             inquirythanks GET      /inquirythanks(.:format)               inquiry#thanks
#               users_index GET      /users/index(.:format)                 users#index
#                users_show GET      /users/show(.:format)                  users#show
#                     about GET      /about(.:format)                       about#conpany_overview
#                     blogs GET      /blogs(.:format)                       blogs#index
#                           POST     /blogs(.:format)                       blogs#create
#                  new_blog GET      /blogs/new(.:format)                   blogs#new
#                 edit_blog GET      /blogs/:id/edit(.:format)              blogs#edit
#                      blog GET      /blogs/:id(.:format)                   blogs#show
#                           PATCH    /blogs/:id(.:format)                   blogs#update
#                           PUT      /blogs/:id(.:format)                   blogs#update
#                           DELETE   /blogs/:id(.:format)                   blogs#destroy
# rambulance_exceptions_app          /rambulance                            Rambulance::ExceptionsApp
#

Rails.application.routes.draw do

  get 'about/conpany_overview'

  devise_for :users, controllers: {
  sessions: "users/sessions",
  registrations: "users/registrations",
  passwords: "users/passwords",
  omniauth_callbacks: "users/omniauth_callbacks"
}
  resources :users, :only => [:index,:show]

  root 'top#index'
  get 'inquiry' => 'inquiry#index'
  post 'inquiry/confirm' => 'inquiry#confirm'
  post 'inquiry' => 'inquiry#create'
  get 'inquirythanks' => 'inquiry#thanks'
  get 'inquiryshow' => 'inquiry#show'

    get 'users/index'

  get 'users/show'

  get 'about' => 'about#conpany_overview'


  resources :blogs
end
