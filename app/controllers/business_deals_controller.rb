class BusinessDealsController < ApplicationController
  before_filter :admin_logged_in?
  
  # GET /business_deals
  # GET /business_deals.xml
  def index
    @business_deals = BusinessDeal.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @business_deals }
    end
  end

  # GET /business_deals/1
  # GET /business_deals/1.xml
  def show
    @business_deal = BusinessDeal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @business_deal }
    end
  end

  # GET /business_deals/new
  # GET /business_deals/new.xml
  def new
    @business_deal = BusinessDeal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @business_deal }
    end
  end

  # GET /business_deals/1/edit
  def edit
    @business_deal = BusinessDeal.find(params[:id])
  end

  # POST /business_deals
  # POST /business_deals.xml
  def create
    @business_deal = BusinessDeal.new(params[:business_deal])

    respond_to do |format|
      if @business_deal.save
        format.html { redirect_to(business_deals_url, :notice => 'Business deal was successfully created.') }
        format.xml  { render :xml => business_deals_url, :status => :created, :location => @business_deal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @business_deal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /business_deals/1
  # PUT /business_deals/1.xml
  def update
    @business_deal = BusinessDeal.find(params[:id])

    respond_to do |format|
      if @business_deal.update_attributes(params[:business_deal])
        format.html { redirect_to(@business_deal, :notice => 'Business deal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @business_deal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /business_deals/1
  # DELETE /business_deals/1.xml
  def destroy
    @business_deal = BusinessDeal.find(params[:id])
    @business_deal.destroy

    respond_to do |format|
      format.html { redirect_to(business_deals_url) }
      format.xml  { head :ok }
    end
  end
  
end
