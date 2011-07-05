function popup(){
	$("button").click(function () {
		$("#product_popup").show()
	});
}

function save(){
	alert("hello");
}

function close_popup(){
	alert("hello");
	$("#product_popup").hide();
}

function show_selected(){
	var txt = parseInt($(".popup_add_box").find("select").val());
	switch(txt){
		case 0:
			$(".popup_add_box").find("#book").hide();
			$(".popup_add_box").find("#mobile").hide();
			$(".popup_add_box").find("#music").hide();
			$(".popup_add_box").find("#games").hide();
			$(".popup_add_box").find("#beverages").hide();
			break;
		case 1:
			$(".popup_add_box").find("#book").show();
			$(".popup_add_box").find("#mobile").hide();
			$(".popup_add_box").find("#music").hide();
			$(".popup_add_box").find("#games").hide();
			$(".popup_add_box").find("#beverages").hide();
			break;
		case 2:
			$(".popup_add_box").find("#book").hide();
			$(".popup_add_box").find("#mobile").show();
			$(".popup_add_box").find("#music").hide();
			$(".popup_add_box").find("#games").hide();
			$(".popup_add_box").find("#beverages").hide();
			break;
		case 3:
			$(".popup_add_box").find("#book").hide();
			$(".popup_add_box").find("#mobile").hide();
			$(".popup_add_box").find("#music").show();
			$(".popup_add_box").find("#games").hide();
			$(".popup_add_box").find("#beverages").hide();
			break;
		case 4:
			$(".popup_add_box").find("#book").hide();
			$(".popup_add_box").find("#mobile").hide();
			$(".popup_add_box").find("#music").hide();
			$(".popup_add_box").find("#games").show();
			$(".popup_add_box").find("#beverages").hide();
			break;
		case 5:
			$(".popup_add_box").find("#book").hide();
			$(".popup_add_box").find("#mobile").hide();
			$(".popup_add_box").find("#music").hide();
			$(".popup_add_box").find("#games").hide();
			$(".popup_add_box").find("#beverages").show();
			break;
		default:
			$(".popup_add_box").find("#book").hide();
			$(".popup_add_box").find("#mobile").hide();
			$(".popup_add_box").find("#music").hide();
			$(".popup_add_box").find("#games").hide();
			$(".popup_add_box").find("#beverages").hide();
			break;
	}
}

function show_link() {
	$("#link").show();
	$(".product_photo").hide();
}

function show_upload() {
	$("#link").hide();
	$(".product_photo").show();
}
