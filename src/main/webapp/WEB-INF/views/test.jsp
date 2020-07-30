<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<script src="resources/js/tui-code-snippet.js"></script>
<script src="resources/js/tui-pagination.js"></script>
<script src="resources/js/tui-time-picker.js"></script>
<script src="resources/js/tui-date-picker.js"></script>
<script src="resources/js/tui-grid.js"></script>
<style>
html {
	margin: 0;
	padding: 0;
}

#form {
	display:block;
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

.preset {
	margin-bottom: 15px;
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
	font-size: 15px;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	overflow: hidden;
}

.preset {
	margin-left: 2rem;
}
</style>
</head>
<body>
	<div id="depa" value="${depart}"></div>
		<div id="grid" style="width: 70%">
			<div style="display: flex;">
				<div id="crud" style="padding-bottom: 15px;">
					<h4>CRUD</h4>
					<button class="btn-theme" onclick="fnBtnCrud('add')">ADD</button>
					<button class="btn-theme" onclick="fnBtnCrud('create')">CREATE</button>
					<button class="btn-theme" onclick="fnBtnCrud('update')">UPDATE</button>
					<button class="btn-theme" onclick="fnBtnCrud('delete')">DELETE</button>
				</div>
				<div class="preset">
					<h4>테마</h4>
					<button class="btn-theme" data-preset="default">default</button>
					<button class="btn-theme" data-preset="striped">striped</button>
					<button class="btn-theme" data-preset="clean">clean</button>
				</div>
			</div>
		</div>
		<div id="theme">

			<div class="custom" style="display: none;">
				<h4>CUSTOM OPTIONS</h4>
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
				<p>
					<button class="btn-custom">APPLY</button>
				</p>
			</div>
		</div>
</body>
<script src="resources/js/test.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	var depart = $("#depa").val();
		callGrid(depart);
	});
</script>
</html>