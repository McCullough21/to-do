class TasksController < ApplicationController


 get '/new' do
   erb :"tasks/create"
 end


end
