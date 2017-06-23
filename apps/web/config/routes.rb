# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get "/", to: "home#index"
get "/user/:id/chart", to: "user#chart"
get "/user/:id", to: "user#show"

get "/auth/failure", to: "session#failure"
get "/auth/signout", to: "session#destroy"
get "/auth/:provider/callback", to: "session#new"
