function include(destination) {
var e=window.document.createElement('script');
e.setAttribute('src',destination);
window.document.body.appendChild(e);
}

d = new Date();
var j = d.getDate();
var h = d.getHours();  

$(document).ready(function(){
	include("../../_INCLUDE/js/interact.js?"+j+h)  
	include("../../_INCLUDE/js/functions.js?"+j+h)	
	include("js/interact.inc.js?"+j+h)
	
	if ( $("#mode").val() == 'liste') {
		include("js/data.inc.js?"+j+h)        
		include("../../_INCLUDE/js/liste.js?"+j+h)
	} else {
		include("../../_INCLUDE/js/fiche.js?"+j+h)
		}
})