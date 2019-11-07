/**
 * 
 */
$.ajaxSetup({async:false});
$.getScript("/resources/common/js/jsbn.js");
$.getScript("/resources/common/js/prng4.js");
$.getScript("/resources/common/js/rng.js");
$.getScript("/resources/common/js/rsa.js");
$.getScript("/resources/common/js/base64.js");
$.ajaxSetup({async:true});
var now;
var modulus = 'B14C5FC5C617CD22650ABF6B3D704D047BE4E86A3786EB7BA1EF23B5CAAE77D70501697204465018B2DDCFBE5C9B590011EAE4F6F5D36EEC01774694EA334C9F295547E80510901316C87C884E75B5F17FB741876CFE49E0E4A155304E242A5FABD109E9C283F67CF75861D2C02093A34145150EA59951BC7D888122713C2CB1';
var exponent = '10001';
function encrypt(s) {
	var rsa = new RSAKey();
	rsa.setPublic(modulus, exponent);
	var res = rsa.encrypt(s + ' ' + now);
	return hex2b64(res);
}

$(function() {
	var scripts = document.getElementsByTagName('script');
	for (var i = 0; i < scripts.length; i++) {
		if (scripts[i].src.indexOf('/resources/common/js/encrypt.js') > -1) {
			queryString = scripts[i].src.replace(/^[^\?]+\??/, '');
			params = getParams(queryString);
			break;
		}
	}
	try {
		now = params['now'] + '';
	} catch (e) {
	}
});

function getParams(query) {
	var params = new Object();
	if (!query) {
		return parmas;
	}
	
	var pairs = query.split(/[\&]/);
	for (var i = 0; i < pairs.length; i++) {
		var keyValue = pairs[i].split('=');
		if (!keyValue || keyValue.length != 2) {
			continue;
		}
		var key = unescape(keyValue[0]);
		var val = unescape(keyValue[1]);
		val = val.replace(/\+/g, ' ');
		params[key] = val;
	}
	
	return params;
}