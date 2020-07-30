<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
<!-- <link rel="stylesheet" href="https://uicdn.toast.com/grid/v4.14.0/tui-grid.css" /> -->
<!-- <script src="https://uicdn.toast.com/grid/v4.14.0/tui-grid.js"></script> -->
<link rel="stylesheet" href="resources/css/tui-grid.css" type="text/css" />
<link rel="stylesheet" href="resources/css/tui-pagination.css"
	type="text/css" />
<link rel="stylesheet" href="resources/css/tui-date-picker.css"
	type="text/css" />
<link rel="stylesheet" href="resources/css/tui-time-picker.css"
	type="text/css" />
<link rel="stylesheet" href="resources/css/tui-chart.css"
	type="text/css" />
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<script src="resources/js/tui-code-snippet.js"></script>
<script src="resources/js/tui-pagination.js"></script>
<script src="resources/js/tui-time-picker.js"></script>
<script src="resources/js/tui-date-picker.js"></script>
<script src="resources/js/tui-grid.js"></script>
<script src="resources/js/tui-chart-all.js"></script>
<style>
#crud{
	margin-top: 1rem;
}


#form {
	display: block;
	margin: 0 auto;
}

#grid {
	width: 1000px;
	float: left;
}

#theme {
	width: 200px;
	float: left;
}

#custom-text {
	width: 300px;
	height: 400px;
	font-size: 12px;
}

h4 {
	margin: 5px 0;
}


.custom p {
	margin: 5px 0;
}

.tui-pagination.tui-grid-pagination {
	display: none;
}

.tui-select-box {
	position: fixed;
	width: 9rem;
}

.tui-select-box-dropdown {
	height: 400px;
}

.tui-grid-cell.tui-grid-cell-header {
	font-size: 15px;
	background: #0098e6;
}

.tui-grid-cell-content {
	font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
	font-size: 15px;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}
.tui-grid-cell.tui-grid-cell-summary{
	text-align: center;
}

</style>
</head>
<body>
	<div id="depa" value="${depart}"></div>
	<div id="grid" style="width: 100%;">
		<div class="preset">
			<h4>테마</h4>
			<button class="btn-theme" data-preset="default">default</button>
			<button class="btn-theme" data-preset="striped">striped</button>
			<button class="btn-theme" data-preset="clean">clean</button>
		</div>
		<div id="theme">
			<div class="custom" style="display: none;">
				<p>
					<textarea id="custom-text">
						{
						  selection: {
						    background: '#4daaf9',
						    border: '#004082'
						  },
						  scrollbar: {
						    background: '#f5f5f5',
						    thumb: '#d9d9d9',
						    active: '#c1c1c1'
						  },
						  row: {
						    even: {
						      background: '#f3ffe3'
						    },
						    hover: {
						      background: '#ccc'
						    }
						  },
						  cell: {
						    normal: {
						      background: '#fbfbfb',
						      border: '#e0e0e0',
						      showVerticalBorder: true
						    },
						    header: {
						      background: '#eee',
						      border: '#ccc',
						      showVerticalBorder: true
						    },
						    rowHeader: {
						      border: '#ccc',
						      showVerticalBorder: true
						    },
						    editable: {
						      background: '#fbfbfb'
						    },
						    selectedHeader: {
						      background: '#d8d8d8'
						    },
						    focused: {
						      border: '#418ed4'
						    },
						    disabled: {
						      text: '#b0b0b0'
						    }
						  }
						}
					</textarea>
				</p>
			</div>
			<p>
				<button style="display: none;" class="btn-custom">APPLY</button>
			</p>
		</div>
	</div>
	<div id="crud" style="display: inline-block;">
		<button id="add" class="btn-theme" onclick="fnBtnCrud('add')">ADD</button>
		<button class="btn-theme" onclick="fnBtnCrud('create')">CREATE</button>
		<button class="btn-theme" onclick="fnBtnCrud('update')">UPDATE</button>
		<button class="btn-theme" onclick="fnBtnCrud('delete')">DELETE</button>
	</div>


</body>
<script src="resources/js/test.js"></script>
<script src="resources/js/chart.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	var depart = $("#depa").val();
		callGrid(depart);
		chart();
	});
</script>
</html>