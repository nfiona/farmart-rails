Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # orders could also be join between products (belongs to vendor) and consumers. this might be ideal

  # fearless 3x nesting!
  resources :vendors do
    resources :products do
      resources :orders
    end
  end

  # correspond to Create and Destroy for orders
  # maybe make a separate controller for a shopping cart,
  # if not a separate model.

  # You may have been headed this way with your
  # consumers model but i think you'd still want a separate controller for shopping carts.


  # resources :orders do
  #   member do
  #     post "add_product"
  #     delete "delete_product"
  #   end
  # end

  root to: redirect("/vendors")

end
