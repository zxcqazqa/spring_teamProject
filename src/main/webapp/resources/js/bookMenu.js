console.log('bookMenu');

$(function() {
	
	// a태그 클릭 이벤트
	$('.bookMenu a').on('click',function(e){
		e.preventDefault();
		let href = $(this).attr('href'); // 자신의 href속성값 가져옴
		let cate_id = $(this).attr('cateId'); // 자신의 cateId속성값 가져옴
		let subCate_id = $(this).attr('subCateId'); // 자신의 cateId속성값 가져옴
		
		let form = $('<form>');
		form.attr('method','get')
		if(cate_id != undefined && subCate_id != undefined) { // cate_id, subCate_id 둘 다 있으면
			form.attr('action',`${contextPath}/${href}/${cate_id}/${subCate_id}`)
		}
		else if(cate_id != undefined && subCate_id == undefined){ // cate_id만 있으면
			form.attr('action',`${contextPath}/${href}/${cate_id}`)
		}
		else {
			form.attr('action',`${contextPath}/${href}`)
		}
		form.appendTo('body')
			.submit();
	});
	
});