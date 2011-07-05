var product_id,updating=true,topEdit,currentEdit;

function loadXMLString(txt)
{
	if(window.DOMParser) {
		parser = new DOMParser();
		xmlDoc=parser.parseFromString(txt,"text/xml");		
	}
	else {
		xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
		xmlDoc.async = false;
		xmlDoc.loadXML(txt);
	}
	
	return xmlDoc;
}

function fillInSuggestion(data)
{	
	var response = loadXMLString(data);
	list = response.getElementsByTagName("S");
	html = '';
	height = 20;
	left=33
	for(i=0;i<list.length;i++) {
		html+='<a href="http://localhost:3000/products/'+list[i].getElementsByTagName("id")[0].textContent+'"><img src=http://localhost:3000'+list[i].getElementsByTagName('image')[0].textContent+' width=100px height=120px style="position:absolute;top:'+height+'px;left:'+left+'px;"></img></a>'
		if(i%2==0) {
			left=166;
		} else {
			left=33;
			height=height+140;
		}
	}
	document.getElementById("suggestion").innerHTML=html;
}

function populateSuggestion(i,j) 
{
	var xmlhttp;
	
	if(window.XMLHttpRequest)
		xmlhttp = new XMLHttpRequest();
	else
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	
	xmlhttp.open("GET","suggestion?product_id="+product_id+"&lower="+i+"&upper="+j,true);
	xmlhttp.send();
	
	xmlhttp.onreadystatechange = function populateS() {
		txt = xmlhttp.responseText;
		if(xmlhttp.status == 200) {
			fillInSuggestion(txt);
		}
	}
}

function fillInRecent(data)
{	
	var response = loadXMLString(data);	
	rcnt = document.getElementById("recent_updates");	
	html='<label style="padding-left:20px;"><font size=3 color="blue">Most Recent</font></label><hr style="position:absolute;top:10px;color:gray;width:300px;"/><br/>';
	var list = response.getElementsByTagName('E');
	for(i=0;i<list.length;i++) {
		html+='<div style="position:relative;width:300px;" onclick="fillP2('+list[i].getElementsByTagName("eid")[0].textContent+');">'
		html+='<img width=70 height=70 src="http://localhost:3000'+list[i].getElementsByTagName('user')[0].getElementsByTagName('pic')[0].textContent+'"></img>'
		html+='<label style="position:absolute;top:25px;left:120px;"><font size=3 color="red">Satisfies  <u>'+list[i].getElementsByTagName('likes')[0].textContent+'</u></font></label>'
		html+='</div><br/>'
	}	
	rcnt.innerHTML=html	
}

function populateRecent(i,j)
{
	var xmlhttp;	
	if(window.XMLHttpRequest)
		xmlhttp = new XMLHttpRequest();
	else
		xmlhttp = new ActiveXObject("Microsoft.XMlHTTP");	
	xmlhttp.open("GET","recentupdate?product_id="+product_id+"&lower="+i+"&upper="+j,true);
	xmlhttp.send();	
	xmlhttp.onreadystatechange = function populateR() {		
		txt = xmlhttp.responseText;
		if(xmlhttp.status == 200) {									
			fillInRecent(txt.substring(0,txt.search("<text/>")));
		}
	}
}

function fillInFriendList(data)
{
	var response = loadXMLString(data);
	frnd = document.getElementById("friends_updates");	
	html='<label style="padding-left:20px;"><font size=3 color="blue">My Friends</font></label><hr style="position:absolute;top:10px;color:gray;width:300px;"/><br/>';
	var list = response.getElementsByTagName('E');
	for(i=0;i<list.length;i++) {
		html+='<div style="position:relative;width:300px;" onclick="fillP2('+list[i].getElementsByTagName("eid")[0].textContent+');">'
		html+='<img width=70 height=70 src="http://localhost:3000'+list[i].getElementsByTagName('user')[0].getElementsByTagName('pic')[0].textContent+'"></img>'
		html+='<label style="position:absolute;top:25px;left:120px;"><font size=3 color="red">Satisfies  <u>'+list[i].getElementsByTagName('likes')[0].textContent+'</u></font></label>'
		html+='</div><br/>'
	}
	frnd.innerHTML=html	
}

function populateFriendsUpdate(i,j)
{
	var xmlhttp;
	if(window.XMLHttpRequest)
		xmlhttp = new XMLHttpRequest();
	else
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		
	xmlhttp.open("GET","friendsupdate?product_id="+product_id+"&lower="+i+"&upper="+j,true);
	xmlhttp.send();
	xmlhttp.onreadystatechange = function populateF() {
		txt=xmlhttp.responseText;
		if(xmlhttp.status == 200) {						
			fillInFriendList(txt.substring(0,txt.search("<text/>")));
		}		
	}
}

function fillInTopList(data)
{	
	response = loadXMLString(data);
	cmnt = document.getElementById("toplist");
	html='<label style="padding-left:20px;"><font size=3 color="blue">All Web</font></label><hr style="position:absolute;top:10px;color:gray;width:300px;"/><br/>';
	var list = response.getElementsByTagName('E');	
	for(i=0;i<list.length;i++) {
		if(i==0) {
			topEdit = list[i].getElementsByTagName("eid")[0].textContent;
		}
		html+='<div style="position:relative;width:300px;" onclick="fillP2('+list[i].getElementsByTagName("eid")[0].textContent+');">'
		html+='<img width=70 height=70 src="http://localhost:3000'+list[i].getElementsByTagName('user')[0].getElementsByTagName('pic')[0].textContent+'"></img>'
		html+='<label style="position:absolute;top:25px;left:120px;"><font size=3 color="red">Satisfies  <u>'+list[i].getElementsByTagName('likes')[0].textContent+'</u></font></label>'
		html+='</div><br/>'
	}
	cmnt.innerHTML=html	
}

function populateToplist(lower,upper)
{
	var xmlhttp;
	if(window.XMLHttpRequest)
		xmlhttp = new XMLHttpRequest();
	else
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		
	xmlhttp.open("GET","toplist?product_id="+product_id+"&lower="+lower+"&upper="+upper,true);
	xmlhttp.send();
	xmlhttp.onreadystatechange = function populateF() {
		txt = xmlhttp.responseText;
		if(xmlhttp.status == 200) {			
			fillInTopList(txt.substring(0,txt.search("<text/>")));			
			if(topEdit != undefined)
				fillP2(topEdit);
		}		
	}
}

function removeComment(uid,cid)
{	
	var xmlhttp;
	if(window.XMLHttpRequest)
		xmlhttp = new XMLHttpRequest();
	else
		xmlhttp = new ActiveXObject();
	
	xmlhttp.open("GET","removecomment?uid="+uid+"&cid="+cid,true);
	xmlhttp.send();
	xmlhttp.onreadystatechange = function update() {
		if(xmlhttp.status == 200)
			populateComments(0,1);
	}
}

function removeReply(uid,cid)
{			
	var xmlhttp;
	if(window.XMLHttpRequest)
		xmlhttp = new XMLHttpRequest();
	else
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		
	xmlhttp.open("GET","removereply?uid="+uid+"&cid="+cid,true);
	xmlhttp.send();
	xmlhttp.onreadystatechange = function update() {
		if(xmlhttp.status == 200)
			populateComments(0,1);
	}
}

function fillInComments(response)
{
	cmnt = document.getElementById("commentlist");	
	html=''
	list = response.getElementsByTagName("list");
	for(i=0;i<list.length;i++) {		
		try {
			html += '<div style="position:relative;" id="c_'+list[i].getElementsByTagName('id')[0].textContent+'">';
			user=list[i].getElementsByTagName('user')[0];		
			html+='<img style="position:absolute;width:50px;height:50px;" src="http://localhost:3000'+user.getElementsByTagName('pic')[0].textContent+'"></img>';
			html+='<div style="padding-left:55px;"><div style="width:350px;"><a href="http://localhost:3000/users/'+user.getElementsByTagName('uid')[0].textContent+'">'+user.getElementsByTagName('name')[0].textContent+'   </a>    '+list[i].getElementsByTagName('cmnt')[0].textContent+'</div>';
			html+='<a href="javascript:removeComment('+user.getElementsByTagName('uid')[0].textContent+','+list[i].getElementsByTagName('id')[0].textContent+')"><div style="width=10px;height:10px;position:absolute;top:0px;left:400px;">X</div></a>';
			html+='<br/><textarea style="width:400px;height:20px;resize:none;" onkeypress="Reply(event,'+list[i].getElementsByTagName("id")[0].textContent+',this)"></textarea>';
			html+='</div>'
			html+='<br/><div id="replies">';
			replies = list[i].getElementsByTagName('reply');
		}catch(e) {alert(e);}
		for(j=0;j<replies.length;j++) {
			try {
				html+='<div style="position:relative">'
				html+='<div style="padding-left:50px;" id="r_'+replies[j].getElementsByTagName('cid')[0].textContent+'"><img style="width:32px;height:32px;" src="http://localhost:3000'+replies[j].getElementsByTagName('pic')[0].textContent+'"></img>';
				html+='<a href="http://localhost:3000/users/'+replies[j].getElementsByTagName('uid')[0].textContent+'">'+replies[j].getElementsByTagName('name')[0].textContent+'  </a>'+replies[j].getElementsByTagName('says')[0].textContent;
				html+='<a href="javascript:removeReply('+replies[j].getElementsByTagName('uid')[0].textContent+','+replies[j].getElementsByTagName('cid')[0].textContent+')"><div style="width=10px;height:10px;position:absolute;top:0px;left:400px;">X</div></a>'
				html+='</div><br/>';
			}catch(e) {alert(e)}
		}		
		html+='</div><br/>';
	}		
	cmnt.innerHTML=html;
}

function populateComments(i,j)
{
	var xmlhttp;
	if(window.XMLHttpRequest)
		xmlhttp = new XMLHttpRequest();
	else
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		
	xmlhttp.open("GET","commentlist?product_id="+product_id+"&start="+i+"&total="+j,true);
	xmlhttp.send();	
	xmlhttp.onreadystatechange = function populateF() {
		txt = xmlhttp.responseText;
		if(xmlhttp.status == 200) {			
			var response = loadXMLString(txt.substring(0,txt.search("<to_xml/>")));
			fillInComments(response);
		}		
	}
}

function fillP2Field(data)
{	
	response = loadXMLString(data);	
	try {
		document.getElementById("field1").innerHTML = response.getElementsByTagName("field1")[0].textContent
		document.getElementById("field2").innerHTML = response.getElementsByTagName("field2")[0].textContent		
		switch(response.getElementsByTagName("category")[0].textContent) {
			case "1":
				document.getElementById("field3").innerHTML = response.getElementsByTagName("field3")[0].textContent
				break;			
			case "2":
				document.getElementById("field3").innerHTML = response.getElementsByTagName("field3")[0].textContent
				document.getElementById("field4").innerHTML = response.getElementsByTagName("field4")[0].textContent
				break;
			case "3":
				document.getElementById("field3").innerHTML = response.getElementsByTagName("field3")[0].textContent
				document.getElementById("field4").innerHTML = response.getElementsByTagName("field4")[0].textContent
				break;
			case "4":
				document.getElementById("field3").innerHTML = response.getElementsByTagName("field3")[0].textContent
				document.getElementById("field4").innerHTML = response.getElementsByTagName("field4")[0].textContent
				document.getElementById("field5").innerHTML = response.getElementsByTagName("field5")[0].textContent
				break;		
			case "5":
				document.getElementById("field3").innerHTML = response.getElementsByTagName("field3")[0].textContent
				document.getElementById("field4").innerHTML = response.getElementsByTagName("field4")[0].textContent
				break;
		}	
	}catch(e) { alert(e) }
}

function fillP2(edit_id)
{	
	var xmlhttp;
	if(window.XMLHttpRequest)
		xmlhttp = new XMLHttpRequest();
	else
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		
	xmlhttp.open("GET","editSection?product_id="+product_id+"&edit_id="+edit_id,true);
	xmlhttp.send();
	xmlhttp.onreadystatechange = function fillEdit() {
		txt = xmlhttp.responseText;
		if(xmlhttp.status == 200) {			
			fillP2Field(txt.substring(0,txt.search("<to_xml/>")))
			document.getElementById("sbmt").innerHTML="Contribute";				
			currentEdit = edit_id;
		}
	}
}

function satisfiedBy()
{
	var xmlhttp;
	if(currentEdit != undefined) {
		if(window.XMLHttpRequest)
			xmlhttp = new XMLHttpRequest();
		else
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp.open("GET","satisfyby?edi="+currentEdit,true);
		xmlhttp.send();
		xmlhttp.onreadystatechange = function satisfied() {
			var response = xmlhttp.responseText;
			if(xmlhttp.status == 200 && response.length > 0)
				alert("You liked this user's edit");
		}
	}
}

function getProductId()
{	
	product_id = document.getElementById("product_id").value;	
	try {
		populateComments(0,1);	
		populateToplist(0,1);
		populateFriendsUpdate(0,1);
		populateRecent(0,1);		
		populateSuggestion(0,5);
	}catch(e) { alert(e); }
}

function registerToServer(category,field1,field2,field3,field4,field5)
{
	var xmlhttp;
	if(window.XMLHttpRequest)
		xmlhttp = new XMLHttpRequest();
	else
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		
	xmlhttp.open("GET","editbyuser?pid="+product_id+"&field1="+field1+"&field2="+field2+"&field3="+field3+"&field4="+field4+"&field5="+field5+"&category="+category,true);
	xmlhttp.send();
	xmlhttp.onreadystatechange = function informUser() {
		if(xmlhttp.status == 200)
			alert("Edit have been committed");
	}
}

function MakeEditable(category)	
{
	if(updating) {
		document.getElementById("field1").innerHTML="<textarea style='width:400px;height:50px;resize:none'></textarea>";
		document.getElementById("field2").innerHTML="<textarea style='width:400px;height:50px;resize:none'></textarea>";
		
		switch(category) {
			case 1:
				document.getElementById("field3").innerHTML="<textarea style='width:400px;height:50px;resize:none;'></textarea>";
				break;
			case 2:
				document.getElementById("field3").innerHTML="<textarea style='width:400px;height:50px;resize:none'></textarea>";
				document.getElementById("field4").innerHTML="<textarea style='width:400px;height:50px;resize:none'></textarea>";
				break;
			case 3:
				document.getElementById("field3").innerHTML="<textarea style='width:400px;height:50px;resize:none'></textarea>";
				document.getElementById("field4").innerHTML="<textarea style='width:400px;height:50px;resize:none'></textarea>";
				break;
			case 4:
				document.getElementById("field3").innerHTML="<textarea style='width:400px;height:50px;resize:none'></textarea>";
				document.getElementById("field4").innerHTML="<textarea style='width:400px;height:50px;resize:none'></textarea>";
				document.getElementById("field5").innerHTML="<textarea style='width:400px;height:50px;resize:none'></textarea>";
				break;
			case 5:
				document.getElementById("field3").innerHTML="<textarea style='width:400px;height:50px;resize:none'></textarea>";
				document.getElementById("field4").innerHTML="<textarea style='width:400px;height:50px;resize:none'></textarea>";
				break;
		}
		updating = false;
		document.getElementById("sbmt").innerHTML="Submit";
	} else {
		field1 = document.getElementById("field1").firstChild.value;
		field2 = document.getElementById("field2").firstChild.value
		
		document.getElementById("field1").innerHTML = field1
		document.getElementById("field2").innerHTML = field2
		
		switch(category) {
			case 1:
				field3 = document.getElementById("field3").firstChild.value
				
				document.getElementById("field3").innerHTML = field3
				registerToServer(category,field1,field2,field3);
				break;
			case 2:
				field3 = document.getElementById("field3").firstChild.value
				field4 = document.getElementById("field4").firstChild.value
				
				document.getElementById("field3").innerHTML = field3
				document.getElementById("field4").innerHTML = field4
				
				registerToServer(category,field1,field2,field3,field4);
				break;
			case 3:
				field3 = document.getElementById("field3").firstChild.value
				field4 = document.getElementById("field4").firstChild.value
				
				document.getElementById("field3").innerHTML = field3
				document.getElementById("field4").innerHTML = field4
				
				registerToServer(category,field1,field2,field3,field4);
				break;
			case 4:
				field3 = document.getElementById("field3").firstChild.value
				field4 = document.getElementById("field4").firstChild.value
				field5 = document.getElementById("field5").firstChild.value
				
				document.getElementById("field3").innerHTML = field3
				document.getElementById("field4").innerHTML = field4
				document.getElementById("field5").innerHTML = field5
				
				registerToServer(category,field1,field2,field3,field4,field5);
				break;
			case 5:		
				field3 = document.getElementById("field3").firstChild.value
				field4 = document.getElementById("field4").firstChild.value
				
				document.getElementById("field3").innerHTML = field3
				document.getElementById("field4").innerHTML = field4
				
				registerToServer(category,field1,field2,field3,field4);
				break;
		}
		updating = true;		
		document.getElementById("sbmt").innerHTML="Contribute";
	}
}

function commentOn(e,value)
{	
	var xmlhttp;
	if(e.keyCode == 13) {
		if(window.XMLHttpRequest)
			xmlhttp = new XMLHttpRequest();
		else
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp.open("GET","commentbyuser?product_id="+product_id+"&comment="+value,true);
		xmlhttp.send();
		xmlhttp.onreadystatechange = function update() {
			if(xmlhttp.status == 200)
				populateComments(0,1);
		}
	}
}

function Reply(e,cid,own)
{
	var xmlhttp;	
	if(own.value.length%50==0) {		
		if(own.value.length != 0) {
			size = (own.value.length/50)*25;
			own.style.height=size+"px";
		}else
			own.value.height="20px";
	}
	if(e.keyCode == 13) {
		if(window.XMLHttpRequest)
			xmlhttp = new XMLHttpRequest();
		else
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp.open("GET","replytocomment?product_id="+product_id+"&c_id="+cid+"&comment="+own.value,true);
		xmlhttp.send();
		xmlhttp.onreadystatechange = function update() {
			if(xmlhttp.status == 200)
				populateComments(0,1);
		}
	}
}

function likeit()
{
	var xmlhttp;
	if(window.XMLHttpRequest)
		xmlhttp = new XMLHttpRequest();
	else
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");	
	xmlhttp.open("GET","likeit?product_id="+product_id,true);
	xmlhttp.send();	
}