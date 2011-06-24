function requestAct(type,uid)
{	
	var xmlhttp;
	if(window.XMLHttpRequest)
		xmlhttp = new XMLHttpRequest();
	else
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		
	var par = document.getElementById("parent");
	var child = document.getElementById(uid);
				
	var param = 'type='+type+'&uid='+uid;
	xmlhttp.open('GET','requestAct?type='+type+'&uid='+uid,true);	
	xmlhttp.setRequestHeader('accept-charset','UTF-8');
	xmlhttp.send();
	xmlhttp.onreadystatechange = function removeElement() {					
			if(xmlhttp.status == 200) {				
				if(par && child)
					par.removeChild(child);
			}
	}
}