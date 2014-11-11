
if ((navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i)) ||(navigator.userAgent.match(/Windows Phone/i))) {
   location.replace("mobileSite/index.mobile.html");
}
var ua = navigator.userAgent.toLowerCase();
var isAndroid = ua.indexOf("android") > -1; 
if(isAndroid) {
	location.replace("mobileSite/index.mobile.html");
}