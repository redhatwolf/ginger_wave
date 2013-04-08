class CreateDosController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @dos = CreateDo.paginate(:page => params[:page], :per_page => 5, :order => 'created_at desc')  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @dos }
    end
  end
  
  def show
    @dos = CreateDo.find(params[:id])
      respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @dos }
    end
  end
  
  # GET /users/new
  # GET /users/new.json
  def new
    @dos = CreateDo.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @dos }
    end   
 end

  def edit
    @dos = CreateDo.find(params[:id])
  end
  
  def update
    @dos = CreateDo.find(params[:id])

    respond_to do |format|
      if @dos.update_attributes(params[:create_do])
        format.html { redirect_to @dos, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @dos.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def create
    @dos = CreateDo.new(params[:create_do])
    respond_to do |format|
      if @dos.save
        #respond_with可以替代 format.html format.xml format.json
#        flash[:notice] = 'Post was successfully created.' if @post.save
#        respond_with(@post)      
        db_method = DBUtil::DbUtil.new
        sql_result = db_method.execute_procedures(@dos.num,@dos.carrier,@dos.warehouse)
        format.html { redirect_to @dos, :notice => "#{sql_result}" }
        format.json { render :json => @dos, :status => :created, :location => @dos }
      else
        format.html { render :action => "new",:notice => "#{@dos.carrier}" }
        format.json { render :json => @dos.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @dos = CreateDo.find(params[:id])
    @dos.destroy

    respond_to do |format|
#      format.html { redirect_to(:action=>"index",:page=>params[:page]) } #删除后返回到删除前的分页位置
      format.html { redirect_to :back }   #使用will_paginate分页插件，当最后一页只有一条记录
      format.json { head :no_content }     #删除之后,还是会停留在最后一页，不能智能进入前一页
    end
  end
  
    module DBUtil
    require 'java'
    import 'oracle.jdbc.driver.OracleDriver'#oracle驱动包
    import 'com.newheight.util.Encrypter'#类似于java中导包
    
    module JavaLang
      include_package "java.lang"
    end
    
    module JavaSql
      include_package "java.sql"
    end
    
    class Encrypter
      require 'openssl'
      require 'base64'
    end
    
    
end

end
