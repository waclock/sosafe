$ ->

	$('.needs-login').click (event) ->
		if (event.ctrlKey||event.metaKey)&&event.which==1
			return true
		else
			event.preventDefault();
			$("#loginModal").modal('show')
