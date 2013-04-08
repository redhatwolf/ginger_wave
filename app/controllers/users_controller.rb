class UsersController < ApplicationController
    # GET /users
  # GET /users.json
  def index
    @users = User.paginate(:page => params[:page], :per_page => 5, :order => 'created_at desc')  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end
  
  def show
    @users = User.find(params[:id])
      respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @users }
    end
  end
  
  # GET /users/new
  # GET /users/new.json
#  def new
#    @users = User.new
#    
#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render :json => @users }
#    end   
# end

  def edit
    @users = User.find(params[:id])
  end
  
  def update
    @users = Post.find(params[:id])

    respond_to do |format|
      if @users.update_attributes(params[:user])
        format.html { redirect_to @users, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @users.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @users = User.find(params[:id])
    @users.destroy

    respond_to do |format|
#      format.html { redirect_to(:action=>"index",:page=>params[:page]) } #删除后返回到删除前的分页位置
      format.html { redirect_to :back }   #使用will_paginate分页插件，当最后一页只有一条记录
      format.json { head :no_content }     #删除之后,还是会停留在最后一页，不能智能进入前一页
    end
  end
  
end
