# Methods added to this helper will be available to all templates in the application.
require "rdf"

module ApplicationHelper
  
  def link_to_add_fields(name)
    fields = render("share/research")
    link_to_function(name, h("add_fields(this, \"#{escape_javascript(fields)}\")"))
  end
  
  def link_to_remove_fields(name)
      link_to_function(name, "remove_fields(this)")
  end
  
  def predicate_helper(uri)
    render "share/predicate_details"
  end
  
  def select_german(labels)
    s = labels.select{|label| label =~ /@de/ }
    if s.empty?
      s = labels.first
    end
    
    s    
  end
  
end
