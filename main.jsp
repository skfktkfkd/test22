<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/admin/goodsReg.css" >
<script src="/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
$(function() {
	$("#img-preview").hide();
	$("#fileIngput").change(fileChanged);
});
function noneSellingPrice() {
	$("#non-btn").addClass("selected");
	$("#set-btn").removeClass("selected");
	$("#set-input").hide();
	$("#set-input input").attr("disabled", true);
}
function setSellingPrice() {
	$("#set-btn").addClass("selected");
	$("#non-btn").removeClass("selected");
	$("#set-input").show();
	$("#set-input input").attr("disabled", false);
}

function fileChanged() {
	if ($("#fileIngput").val() != "") {
		var formData = new FormData();
		var file = $("#fileIngput")[0].files[0];
		formData.append("file", file);
		$.ajax({
			url : "/goods/preView",
			data : formData,
			type : "POST",
			processData : false,
			contentType : false,
			success : function(result) {
				$("#temp").val(result);
				var tempUrl = "/images/temp/"+result;
				$("#img-preview").css("background-image","url(" + tempUrl + ")");
				$("#img-preview").show();
			}
		});
	}

}
</script>
</head>
<body>
<div class="flex">
		<th:block th:insert="/admin/sideMenu::side">
			<!-- 관리자메뉴가 들어갈 영역 -->
		</th:block>
		<section id="content">
			<h1>상품등록</h1>
			<div class="wrap">
				<p class="tit">상품등록</p>
				<form id="goods-form" class="con"  method="post"  enctype="multipart/form-data">
					<ul>
						<li>
							<label>상품명</label>
							<input type="text" name="name" placeholder="상풍명입력">
						</li>
						<li>
							<label>판매가</label>
							<input type="text" name="originPrice" placeholder="숫자만 입력">원
						</li>
						<li>
							<label>할인가</label>
							<div>
								<a><input id="set-btn" type="button" class="adm-btn " onclick="setSellingPrice()" value="설정"/> </a>
								<a><input id="non-btn" type="button" class="adm-btn selected" onclick="noneSellingPrice()" value="설정안함"/></a>
								<div id="set-input">
									<input  type="text" name="sellingPrice" placeholder="할인판매가 입력" disabled="disabled">원
								</div>
							</div>
						</li>
						<li>
							<label>상품이미지</label>
							<!-- 아래 label태그를 파일버튼으로 활용 -->
							<div id="file-wrap">
								<label for="fileIngput" class="file-btn">+</label>
								<input type="file" name="file" id="fileIngput">
								<p>권장크기 : 1000*1000</p>
								
								<input type="hidden" id="temp" name="temp">
								
								<div id="img-preview" class="flex-column-end">
									<div class="control-btn">
										<ul><li><label for="fileIngput">수정</label></li></ul>
									</div>
								</div>
							</div>
						</li>
						<li>
							<input type="submit" value="저장하기">
						</li>

					</ul>

				</form>
			</div>
		</section>
	</div>
</body>
</html> 