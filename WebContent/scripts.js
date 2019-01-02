/**
 * 
 */

function toggle(id) {
	if(document.getElementById(id).style.display == 'inline-block') {
		document.getElementById(id).style.display = 'none';
	}
	else {
		document.getElementById(id).style.display = 'inline-block';
	}
}

function back() {
	window.history.back();
}