

// hiiden 속성의 input 태그 생성 
function getInputHiddenTag(name, value){
	return $('<input/>',{type:"hidden", "name":name, "value" : value})
}

// 쿼리스트링 값 받기 
function getSearchParam(key){
	return new URLSearchParams(location.search).get(key);
}

$(function(){
	//3개로 제한..

})