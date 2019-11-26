Rails.application.routes.draw do
  get "/tex/example", controller: "tex#example"
  get "/tex/example2", controller: "tex#example2"
  get "/tex/example3", controller: "tex#example3"
end
