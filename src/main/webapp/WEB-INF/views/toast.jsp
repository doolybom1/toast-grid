<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- <link rel="stylesheet" href="https://uicdn.toast.com/grid/v4.14.0/tui-grid.css" /> -->
		<!-- <script src="https://uicdn.toast.com/grid/v4.14.0/tui-grid.js"></script> -->
		<link rel="stylesheet" href="resources/css/tui-grid.css" type="text/css"/>
		<link rel="stylesheet" href="resources/css/tui-pagination.css" type="text/css"/>
		<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
		<script src="resources/js/tui-code-snippet.js"></script>
		<script src="resources/js/tui-pagination.js"></script>
		<script src="resources/js/tui-grid.js"></script>
	</head>
	<body>
		Hello World!
		<div id="grid"></div>
	</body>
	<script src="resources/js/toast.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			callGrid();
			/*
			$.ajax({
				url: "ajax/toastDataList.do",
				method: "POST",
				dataType: "json",
				success: function(result) {
					console.log(result[0]);
					grid.resetData(result);
				}
				,error: function(e, x) {
					alert("조회에 실패하였습니다");
				}
			})
			*/
		});
	</script>
</html>