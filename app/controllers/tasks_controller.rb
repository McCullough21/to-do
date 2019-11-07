class TasksController < ApplicationController


 get '/new' do
   if !logged_in?
     redirect '/login'
   else
   erb :"tasks/create"
   end
 end

 post '/new' do
   @user = current_user
   if params[:title].empty?
     flash[:message] = "* Task must have a title *"
     redirect '/new'
   else
   @task = Task.create(title: params[:title], content: params[:content], :user_id => @user.id)
   @task.save
   redirect "/profile/#{@user.id}"
   end
 end

  get '/task/:id/edit' do
    if !logged_in?
      redirect '/login'
    end
    @task = Task.find(params[:id])
    if current_user.id != @task.user_id
      redirect "/profile/#{current_user.id}"
    else
      erb :"tasks/edit"
    end
  end
  
 get '/tasks/:id' do
   @task = Task.find(params[:id])
   erb :"tasks/show"
 end


end
