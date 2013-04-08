class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  respond_to :html, :xml, :json  
  
  def index
    @posts = User.find(params[:user_id]).posts.paginate(:page => params[:page], :per_page => 5, :order => 'created_at desc')  
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = current_user.posts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = current_user.posts.build
    respond_to do |format|
      format.html  # new.html.erb
      format.json { render :json => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(params[:post])
    respond_to do |format|
      if @post.save
        #  respond_to :html, :xml, :json 
        #  respond_with可以替代 format.html format.xml format.json
#        flash[:notice] = 'Post was successfully created.' if @post.save
#        respond_with(@post)
        db_method = DBUtil::DbUtil.new
        sql_result = db_method.execute_procedures(2,"1号店_上海","上海4号仓库")
        format.html { redirect_to @post, :notice => "#{sql_result}" }
        format.json { render :json => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, :notice => 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
#      format.html { redirect_to(:action=>"index",:page=>params[:page]) } #删除后返回到删除前的分页位置
      format.html { redirect_to :back }   #使用will_paginate分页插件，当最后一页只有一条记录
      format.json { head :no_content }     #删除之后,还是会停留在最后一页，不能智能进入前一页
    end
  end
  
  def destroy_multiple
    if params[:post_ids].blank?
      redirect_to :back,:alert => "请选择需要删除的数据"
    else
      posts = Post.find(params[:post_ids])
      posts.each do |post|
        post.destroy
      end
    redirect_to :back, :notice => I18n.t('flash.actions.destroy.notice')  
    end
    rescue => e  
    redirect_to :back, :alert => e.to_s
 
#  respond_to do |format|
#    format.html { redirect_to :back }
#    format.json { head :no_content }
#  end
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
    
    class DbUtil
      #连接数据库，执行查询语句，sql以param形式传入
      
      def create_conn 
        #JavaLang::Class.forName("oracle.jdbc.driver.OracleDriver").newInstance
        ##发现如果直接用Class.forName话根本找不到类。看来jruby是预先导入的直接用import CLASS即可
        passwd = "aixs3GKgn4oVplJGeAI96Q.."
        psd = Encrypter.decrypt(passwd)
        @con = JavaSql::DriverManager.getConnection( \
         "jdbc:oracle:thin:@192.168.128.40:1521:dcwhtest","tms_data2",psd)#"yhdtest123qa")
        if @con == nil
          puts "DB_LINK ERROR"
        end
      end      
      
      #PROC_CREATE_DO(1,'1号店_上海','上海4号仓库');
      def execute_procedures(num,carrier,ware_house)
        create_conn
        pre_call = @con.prepareCall("{call PROC_CREATE_DO(?,?,?)}")
        pre_call.setInt(1,num)
        pre_call.setString(2,carrier)
        pre_call.setString(3,ware_house)
        pre_call.execute
        @con.close
      end
    
  end
end
 
  
  
  
  
  
  
  
end
