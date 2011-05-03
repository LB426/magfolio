class IzbrannoesController < ApplicationController
  # GET /izbrannoes
  # GET /izbrannoes.xml
  def index
    @izbrannoes = Izbrannoe.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @izbrannoes }
    end
  end

  # GET /izbrannoes/1
  # GET /izbrannoes/1.xml
  def show
    @izbranno = Izbrannoe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @izbranno }
    end
  end

  # GET /izbrannoes/new
  # GET /izbrannoes/new.xml
  def new
    @izbranno = Izbrannoe.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @izbranno }
    end
  end

  # GET /izbrannoes/1/edit
  def edit
    @izbranno = Izbrannoe.find(params[:id])
  end

  # POST /izbrannoes
  # POST /izbrannoes.xml
  def create
    client_ip = request.remote_ip
    izbrannoe = Izbrannoe.new
    izbrannoe.identificator = BCrypt::Engine.hash_secret("#{client_ip}#{random_string}", BCrypt::Engine.generate_salt)
    if izbrannoe.save
      response.headers['Content-type'] = "text/plain; charset=utf-8"
      render :text => izbrannoe.to_json( :only => [ :identificator ] )
    else
      render :nothing => true
    end
  end

  # PUT /izbrannoes/1
  # PUT /izbrannoes/1.xml
  def update
    #@izbranno = Izbrannoe.find_by_identificator(params[:identificator])
    @izbranno = Izbrannoe.find_by_identificator_and_catalog_id(params[:identificator], params[:catalog_id] )
    if @izbranno.nil?
      izbrannoe = Izbrannoe.new
      izbrannoe.identificator = params[:identificator]
      izbrannoe.catalog_id = params[:catalog_id]

      if izbrannoe.save
        response.headers['Content-type'] = "text/plain; charset=utf-8"
        render :text => "#{Izbrannoe.where(:identificator => params[:identificator]).count}"
      else
        response.headers['Content-type'] = "text/plain; charset=utf-8"
        render :text => "-1"
      end
    else
      render :nothing => true
    end

  end

  # DELETE /izbrannoes/1
  # DELETE /izbrannoes/1.xml
  def destroy
    #@izbranno = Izbrannoe.find(params[:id])
    @izbranno = Izbrannoe.find_by_identificator_and_catalog_id(params[:identificator], params[:catalog_id] )

    if @izbranno.destroy
      response.headers['Content-type'] = "text/plain; charset=utf-8"
      render :text => "#{Izbrannoe.where(:identificator => params[:identificator]).count}"
    else
      response.headers['Content-type'] = "text/plain; charset=utf-8"
      render :text => "-1"
    end
    
  end
  
  def getmy
    izbrannoe = Izbrannoe.find_all_by_identificator(params[:identificator])
    unless izbrannoe.nil?
      response.headers['Content-type'] = "text/plain; charset=utf-8"
      render :text => izbrannoe.to_json( :only => [ :catalog_id ] )
    else
      render :nothing => true
    end
  end
  
private

  def random_string(size = 32)
    chars = (('a'..'z').to_a + ('0'..'9').to_a)
    (1..size).collect{|a| chars[rand(chars.size)] }.join
  end  
  
end
