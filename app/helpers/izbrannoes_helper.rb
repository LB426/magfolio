module IzbrannoesHelper
  
  def izbrannoe_link
    unless cookies[:izbrannoe].nil?
      return Izbrannoe.find_by_identificator(cookies[:izbrannoe]).link
    end
    ""
  end
  
end
