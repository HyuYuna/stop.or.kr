$(function(){
	//레프트메뉴
	$(".snb li a").bind("click",function(){	
		$(this).next().slideToggle().parent().toggleClass("on");
		$(this).parent().siblings().removeClass("on").children().next().slideUp();
	});
	//탭메뉴
	$(".tabArea ul li, .innerTabArea ul li").bind("click",function(){
		$(this).addClass("on").siblings().removeClass("on");
	});
	//등급관리
	$(".gradeInfo ul li").bind("click",function(){
		$(this).toggleClass("on");
	});

	//테이블목록정렬
	//Helper function to keep table row from collapsing when being sorted
	var fixHelperModified = function(e, tr) {
		var $originals = tr.children();
		var $helper = tr.clone();
		$helper.children().each(function(index)
		{
		  $(this).width($originals.eq(index).width())
		});
		return $helper;
	};
	//Make diagnosis table sortable
	$("#diagnosis_list tbody").sortable({
		helper: fixHelperModified,
		stop: function(event,ui) {renumber_table('#diagnosis_list')}
	}).disableSelection();
	
	//Delete button in table rows
	$('table').on('click','.sDelete',function() {
		tableID = '#' + $(this).closest('table').attr('id');
		r = confirm('정말 삭제 하시겠습니까?');
		if(r) {
			$(this).closest('tr').remove();
			renumber_table(tableID);
			};
	});
	//thumbnail
	$(".sortImg").sortable();
	$(".sortImg").disableSelection();
	$(".sortImg > li > a.imgDelete").bind("click",function(){
		$(this).parent().remove();
	});
	//Renumber table rows
	function renumber_table(tableID) {
		$(tableID + " tr").each(function() {
			count = $(this).parent().children().index($(this)) + 1;
			$(this).find('.priority').html(count);
		});
	};


});
