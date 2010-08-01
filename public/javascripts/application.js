// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function add_fields(link, content) {
	var count = $(link).up().previous(".research").down(".count").innerHTML;
	var regexp = new RegExp("1", "g")
	
  $(link).up().insert({			
	    before: content.replace(regexp,(count *1) + 1)
	 });
}

function remove_fields(link) {
  $(link).up(".research").remove();
}