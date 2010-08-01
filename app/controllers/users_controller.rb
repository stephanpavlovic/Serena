class UsersController < ApplicationController
  
  def index
    @users = User.find
  end
  
  def show
    @user = User.new(params[:uri])
  end
  
  def edit
    @references = SemanticRecord::Base.new("http://www.medieninformatik.fh-koeln.de/miwiki/Spezial:URIResolver/Attribut3AHatLiteratur").rdfs_range.last.find_others    
    @project = Project.new(params[:uri])
  end
  
  def similar_by_area
    @project = Project.new(params[:uri])
    @areas = @project.attribute("http://www.aktors.org/ontology/portal#addresses-generic-area-of-interest")[:value]

      
    @areas = @areas.collect{|area| area.uri}
    
    puts @areas
    
    @projects = []
    @areas.each do |area|
      @projects << Project.find_by_aktors_addresses_generic_area_of_interest_(area)
    end

    @projects = @projects.flatten.uniq_by{|obj| obj.uri}

  end
  
  def new
    @references = SemanticRecord::Base.new("http://www.medieninformatik.fh-koeln.de/miwiki/Spezial:URIResolver/Attribut3AHatLiteratur").rdfs_range.first.find_others    
  end
  
  def create
    #raise params[:project].inspect
    
    @project = Project.new("http://localhost:4567/#{params[:project][:rdfs_label]}")
    
    params[:project].each do |param,value|
      @project.send("#{param}=",value) unless value.blank?
    end
    
    
    @project.save
    
    #raise @project.rdfs_label.inspect
    redirect_to :action => "show", :controller => "projects", :uri => @project.uri
    
  end
  
  def update
    @project = Project.new( params[:project].delete(:uri) )
    
    params[:project].each do |param,value|
      @project.send("#{param}=",value) #unless value.blank?
    end
    @project.save
    
    redirect_to :action => "show", :controller => "projects", :uri => @project.uri
  end
  
end