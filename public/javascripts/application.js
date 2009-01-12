function shower(show_these){
	show_these.each(function(s) {
		$(s).show();
	});
}
function toggler(toggle_these){
	toggle_these.each(function(s) {
	  $(s).toggle();
	});
}
function hider(hide_these){
	hide_these.each(function(s) {
	  $(s).hide();
	});
}