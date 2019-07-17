class UsersController < ApplicationController

  #This function is used to add and update new events
  def save_update_event    
    response = {'status' => false}
    if request.xhr?     
		if params.present? && params[:event_id].present?
			@user_event = UserEvent.find(params[:event_id])
			@user_event.user_id = current_user.id
			@user_event.start = DateTime.parse(params[:start_date]).strftime("%Y-%m-%d")
			@user_event.end = DateTime.parse(params[:end_date]).strftime("%Y-%m-%d")
			@user_event.title = params[:title]
			if @user_event.save
				response = {'status' => true, 'id'=>@user_event.id}
			end
		else		
			@user_event = UserEvent.new
			@user_event.user_id = current_user.id
			@user_event.start = DateTime.parse(params[:start_date]).strftime("%Y-%m-%d")
			@user_event.end = DateTime.parse(params[:end_date]).strftime("%Y-%m-%d")
			@user_event.title = params[:title]
			if @user_event.save
				response = {'status' => true, 'id'=>@user_event.id}
			end				
		end		
		render :json => response 	
    else
      redirect_to root_url and return
    end	
  end  
  
  
  #This function is used to delete events
 def delete_event    
    response = {'status' => false}
    if request.xhr?          
		if params.present? && params[:event_id].present?			 			
			if UserEvent.delete(params[:event_id])
				response = {'status' => true }
			end					
		end		
		render :json => response 
	
    else
      redirect_to root_url and return
    end	
  end 
  
  
  #This function is used to send events data in json form
  def get_events			
    @task = UserEvent.where("user_id"=>current_user.id)
    events = []
    @task.each do |task|
      events << {:id => task.id, :title => task.title, :start => DateTime.parse(task.start.to_s).strftime("%Y-%m-%d"), :end => DateTime.parse(task.end.to_s).strftime("%Y-%m-%d") }
    end
    render :text => events.to_json   
  end  
  
end
