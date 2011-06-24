var new_user=true;

function pushUser(email,passwrd,token,rem_me)
{	
	var xmlhttp;
	var params,login='',sex='',birth=['','',''];	
	
	try {
		login = encodeURIComponent(document.getElementById('usr_first_name').value+" "+document.getElementById('usr_last_name').value);
		sex = encodeURIComponent(document.getElementById('usr_gender').value);
		birth = document.getElementById('usr_birthday').value.split('/');
	} catch(e) {		
	}	
	if(window.XMLHttpRequest)		
		xmlhttp = new XMLHttpRequest();
	else
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	
	try {		
		if(!new_user) {			
			var hiddenparam = encodeURIComponent(document.getElementsByName("utf8")[0].value);
			params="utf8="+hiddenparam+"&authenticity_token="+token+"&user[email]="+email+"&user[remember_me]="+rem_me+"&user[password]="+passwrd+"&commit=Sign in";
			xmlhttp.open("POST",'/users/sign_in',false);			
			xmlhttp.setRequestHeader('accept-charset','UTF-8');
			xmlhttp.setRequestHeader('Content-Type','multipart/form-data');
			xmlhttp.send(params);						
		} else {						
			params='user[login]='+login+'&user[email]='+email+'&user[password]='+passwrd+'&user[confirm_password]='+passwrd+'&user[city_id]=&user[sex]='+sex+'&user[birthday(1i)]='+encodeURIComponent(birth[2])+'&user[birthday(2i)='+encodeURIComponent(birth[0])+'&user[birthday(3i)]='+encodeURIComponent(birth[1])+'&user[profession]=&commit=Sign up';			
			xmlhttp.open("POST",'/users',false);					
			xmlhttp.setRequestHeader('accept-charset','UTF-8');
			xmlhttp.setRequestHeader('Content-Type','multipart/form-data');
			xmlhttp.send(params);			
		}	
	} catch(e) {		
		return;
	}	
	
	window.location = "http://localhost:3000/logUser"
}

function getPushUser()
{			
	var p_btn = document.getElementById("user_password");
	var c_pass = document.getElementById("confirm_password");
	var email = encodeURIComponent(document.getElementById("user_email").value);
	var token = encodeURIComponent(document.getElementsByName("authenticity_token")[0].value);			
	
	if(new_user) {
		try {
			if(p_btn.value != c_pass.value || (p_btn.value.length == 0 || c_pass.value.length == 0)) {
				alert("Password field doesn't match  ");
				return;
			}
		} catch(e) { new_user = false }
	}	
	pushUser(email,encodeURIComponent(p_btn.value),token,encodeURIComponent(0));
}

function verify_email()
{		
	var xmlhttp;
	var email = document.getElementById("user_email").value;
	if(email.length != 0) {		
		try {
			if(window.XMLHttpRequest)		
				xmlhttp = new XMLHttpRequest();
			else
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");			
			xmlhttp.open("GET","verify_user?email="+email,false);
			xmlhttp.send();								
			if(xmlhttp.status == 200) {
				response = xmlhttp.responseText;										
				if(response.indexOf('unavail') != -1) {
					var c_pass = document.getElementById("confirm_pass");
					var s_btn = document.getElementById("sign_button");
					if(c_pass)
						c_pass["style"]["display"]="inline";				
					if(s_btn)
						s_btn['value']='Sign Up';																	
					new_user=true;
				} else {					
					new_user = false;
				}					
			}			
		} catch(e) {			
		}
	} else {
		alert('Unable to fetch email information . :( . Login manuallly');
	}
}