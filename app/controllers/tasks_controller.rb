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

  get '/tasks/:id/edit' do
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

 patch '/tasks/:id' do
   @task = Task.find(params[:id])
    @task.update(content: params[:content])
    @task.save
    redirect "/profile/#{@task.user_id}"
 end

 get '/delete/:id' do
   @task = Task.find(params[:id])
   @task.delete
   redirect "/profile/#{current_user.id}"
 end


end
