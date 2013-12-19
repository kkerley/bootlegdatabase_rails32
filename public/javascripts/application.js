//functions for jQuery adding/removing fields
function remove_fields(link) {  
    $(link).prev("input[type=hidden]").val("1");  
    $(link).closest(".fields").hide();  
}  
  
function add_fields(link, association, content) {  
    var new_id = new Date().getTime();  
    var regexp = new RegExp("new_" + association, "g");  
    $(link).parent().before(content.replace(regexp, new_id));  
}  

// end of functions for adding/removing fields



//functions for Ajax login via Facebox plugin
$(document).ready(function() {
    
	$('#flash_box').fadeOut(3000);
	
	$('#performance_venue_name').autocomplete('/venues.js', {delay: 10, minChars: 1});
	$('#performance_tour_name').autocomplete('/tours.js', {delay: 10});
	$('.auto-complete-song-name').autocomplete('/songs.js', {delay: 10});
	$('#recording_taper_name').autocomplete('/tapers.js', {delay: 10});
	
	$('#textile_example').hide();
	$('#textile_example_link').click(function(){
		$('#textile_example').toggle();
	});
	
	/***************************************
		 
		 All related to facebox pop-ups
	
	*****************************************/
	
	$('#login-link').facebox({
        loadingImage : '/images/loading.gif',
        closeImage   : '/images/closelabel.gif',
    });
	
	$('#login-link-footer').facebox({
        loadingImage : '/images/loading.gif',
        closeImage   : '/images/closelabel.gif',
    });

    $(document).bind('reveal.facebox', function() {
        $('#new_user_session').submit(function() {
            $.post(this.action, $(this).serialize(), null, "script");
            return false;
        });
    });
	
	$('#register-link').facebox({
        loadingImage : '/images/loading.gif',
        closeImage   : '/images/closelabel.gif',
    });
	
	$('#register-link-footer').facebox({
        loadingImage : '/images/loading.gif',
        closeImage   : '/images/closelabel.gif',
    });

    $(document).bind('reveal.facebox', function() {
        $('#new_user').submit(function() {
            $.post(this.action, $(this).serialize(), null, "script");
            return false;
        });
    });
		
	$('#add-new-address').facebox({
        loadingImage : '/images/loading.gif',
        closeImage   : '/images/closelabel.gif',
    });

    $(document).bind('reveal.facebox', function() {
        $('#new_address').submit(function() {
            $.post(this.action, $(this).serialize(), null, "script");
            return false;
        });
    });
	
	$('#contact-link').facebox({
        loadingImage : '/images/loading.gif',
        closeImage   : '/images/closelabel.gif',
    });
	
	$('#contact-link-body').facebox({
        loadingImage : '/images/loading.gif',
        closeImage   : '/images/closelabel.gif',
    });	
	
    $(document).bind('reveal.facebox', function() {
        $('#new_contact').submit(function() {
            $.post(this.action, $(this).serialize(), null, "script");
            return false;
        });
    });
	
	/***************************************
		 
		 All related to auto-complete
	
	*****************************************/
	
	
	
});
