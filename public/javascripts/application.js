// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function () {  
	$('#products .pagination a').live('click', 
		function () {  
			$.getScript(this.href);  
			return false;  
		}  
	);
	
	$('#products_search').submit(function () {  
    $.get(this.action, $(this).serialize(), null, 'script');  
    return false;  
  });
});  