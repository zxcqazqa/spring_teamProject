let takeResultService={

	//승인
	yesResult : function(bookN){
		console.log("책제목 "+bookN.bookName)
		console.log("대여료 "+bookN.takePrice)
		
		$.ajax({
			type : 'post',
			url : `${contextPath}/book/yesUpdate`,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(bookN),
			
			success : function(yesTest) {
				alert(bookN.bookName +'성공');
				$('.modal').hide();
			},
			error : function() {
				alert('실패');			
			}
		});
	
	},
	//거절 및 사유
	noResult : function(bookR){
		console.log("책제목 "+bookR.bookName)
		console.log("사유 "+bookR.reason)
	
		$.ajax({
			type : 'post',
			url : `${contextPath}/book/noUpdate`,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(bookR),
			
			success : function(noTest) {
				$('.modal').hide();
			
			},
			error : function() {
				alert('실패');			
			}
		});
	}

};