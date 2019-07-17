Rails.application.routes.draw do
  root 'homes#index'

  match '/save_update_event' => 'users#save_update_event', :as => :save_update_event, :via => :post
  match '/delete_event' => 'users#delete_event', :as => :delete_event, :via => :post
  match '/get_events' => 'users#get_events', :as => :get_events, :via => :get
  

end

