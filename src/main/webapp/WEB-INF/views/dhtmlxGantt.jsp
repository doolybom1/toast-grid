<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>Month view</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="resources/codebase/dhtmlxgantt.js"></script>
<script src="resources/codebase/api.js?v=7.0.10"></script>
<link rel="stylesheet" href="resources/codebase/dhtmlxgantt.css">
<link rel="stylesheet"
	href="resources/codebase/controls_styles.css?v=7.0.10">

<style>
html, body {
	height: 100%;
	padding: 0px;
	margin: 0px;
	overflow: hidden;
}

.status_line {
	background-color: #0ca30a;
}



.weekend {
	background: #ddd;
}

#search {
	position: static;
	top: 0.7rem !important;
	left: 1rem;
	padding: 5px;
	border-radius: 3px;
	border: 1px solid #D9D9D9;
}

/*
.gantt_layout_cell_border_bottom{
	overflow-y: scroll;
}

div.gantt_grid{
	overflow: auto;
}

.gantt_layout_cell.grid_cell{
	width: auto !important;
}
*/

.gantt_last_cell:hover{
	cursor: pointer;
}

.gantt_task_progress span{
	color: white;
	display: block;

}

</style>
</head>

<body>
	<!-- 
<input type=button value="Emulate +1 date add" onclick="next_day()">
<p id='today'>
 -->
 
	<div class="gantt_control" style="text-align: left;">
	<input data-text-filter id='search' name='text' type='text' placeholder='작업검색' oninput='change_detector()' style="margin-left: 10px;">
		<input type="button" value="확대" onclick="zoomIn()">
	<input type="button" value="축소" onclick="zoomOut()">
	
		<input value="EXCEL 출력" type="button" onclick='gantt.exportToExcel({date_format:"yyyy-M-d"})' > 
		<input value="PDF 출력" type="button" onclick='gantt.exportToPDF({header:"<h1>My company</h1>", footer:"<h4>Bottom line</h4>"})'>
		<input value="PNG 출력" type="button" onclick='gantt.exportToPNG()'>
	</div>
	<div id="gantt_here" style="width:100%; height: 100%;"></div>
<script>

gantt.plugins({
    marker: true,
});	


gantt.templates.timeline_cell_class = function (item, date) {
	if (!gantt.isWorkTime({date: date, task: item})) {
		return "weekend";
	}
};

var colors = [
    {key:"", label:"Default"},
    {key:"#4B0082",label:"Indigo"},
    {key:"#FFFFF0",label:"Ivory"},
    {key:"#F0E68C",label:"Khaki"},
    {key:"#DC143C", label: "Red"}
];

/*
gantt.config.layout = {
		css: "gantt_container",
		cols: [
			{
				width:400,
				min_width: 300,
				rows:[
				{view: "grid", scrollX: "gridScroll", scrollable: true, scrollY: "scrollVer"},
				//{view: "scrollbar", id: "gridScroll", group:"horizontal"}
				]
			},
			{
				rows:[
					{view: "timeline", scrollX: "scrollHor", scrollY: "scrollVer"},
					{view: "scrollbar", id: "scrollHor", group:"horizontal"},
				]
			},
		]
	};
*/
	gantt.config.smart_scales = true;
	gantt.config.reorder_grid_columns = true;
	gantt.config.autosize = true;
	gantt.config.auto_types = true;
	gantt.i18n.setLocale("kr");
	
	var ganttData = ${ganttData};
	var showMessage = function (type) {
		var text = "";
		var countTask = gantt.getTaskCount();
		var countLink = gantt.getLinkCount();

		text += "Tasks count: " + countTask + "<br>";
		text += "Links count: " + countLink + "<br>";


		gantt.message({ type: type, text: text, expire: 10000 });

	}

	gantt.config.date_format = "%Y-%m-%d %H:%i:%s";
	gantt.config.scales = [
			{ unit: "month", step: 1, format: "%Y, %F" },
			{ unit: "day", step: 1, format: "%j" }
		];

	// EndDate를 전날값으로 포함
	function formatEndDate(date, template) {
		// get 23:59:59 instead of 00:00:00 for the end date
		return template(new Date(date.valueOf() - 1));
	}
	  
	gantt.config.columns = [
		 {name:"text", label: "Description" , width:250, tree:true},
			{ name: "start_date", label: "Start date", align: "center", width: "80"},
			{ name: "end_date", label: "End date", align: "center", width: "80", template: function (task) {
				return formatEndDate(task.end_date, gantt.templates.date_grid);
			} },
			{ name: "duration", align: "center", width: 70, resize: true},
			//{ name: "progress",align: "center" , label: "Progress", width: "80", tempalte: dateProgress},
			{ name: "add", width: 44 }
	];

	gantt.locale.labels["section_progress"] = "Progress";
	gantt.locale.labels.section_detail = "Details";
	gantt.locale.labels.section_description = "작업명";
	//gantt.locale.labels.section_priority = "우선순위";
	gantt.locale.labels.section_customFiled = "커스텀 필드";
	gantt.locale.labels.section_color = "작업색";
	gantt.locale.labels.section_period = "기간";

	gantt.config.lightbox.project_sections = [
		{name: "description", height: 70, map_to: "text", type: "textarea", focus: true},
		{ name: "color", height: 38, map_to: "color", type: "select", options:colors },
	    {name: "type", type: "typeselect", map_to: "type"},
	    {name: "time", type: "duration", readonly: true, map_to: "auto"}
	],
	
	gantt.config.lightbox.sections = [
		{ name: "description", height: 38, map_to: "text", type: "textarea", focus: true },
		{ name: "color", height: 38, map_to: "color", type: "select", options:colors },
		{
			name: "progress", height: 22, map_to: "progress", type: "select", options: [
				{key: "0", label: "Not started"},
				{key: "0.1", label: "10%"},
				{key: "0.2", label: "20%"},
				{key: "0.3", label: "30%"},
				{key: "0.4", label: "40%"},
				{key: "0.5", label: "50%"},
				{key: "0.6", label: "60%"},
				{key: "0.7", label: "70%"},
				{key: "0.8", label: "80%"},
				{key: "0.9", label: "90%"},
				{key: "1", label: "Complete"}
			], 
			default_Value: "0"
		},
		//{ name: "detail" , height:25, type : "textarea" , map_to: "text"},
		{ name: "customFiled" , height:25, type : "textarea" , map_to: "myField",readonly: true, default_value: "디폴트값"},
		/*
		{name:"priority", height:22, map_to:"priority", type:"checkbox", options: [ 
	        {key:1, label: "High"},                                               
	        {key:2, label: "Normal"},                                             
	        {key:3, label: "Low"}                                                 
	     ]},
	     */
		{ name: "period", type: "duration", map_to: "auto", year_range: [2018, 2026], template: function (task) {
			return formatEndDate(task.end_date, gantt.templates.date_grid);
		} }
	];


	gantt.config.scale_height = 50;

	gantt.attachEvent("onAfterTaskDrag", function (id, mode) {
		var task = gantt.getTask(id);
		console.log(task);
		if (mode == gantt.config.drag_mode.progress) {
			var pr = Math.floor(task.progress * 100 * 10) / 10;
			gantt.message("<b>"+task.text +"</b>" + " 현재 " + pr + "% 완료됨!");
		} else {
			var convert = gantt.date.date_to_str("%Y-%m-%d");
			//var convert = gantt.date.date_to_str("%F %j");
			var s = convert(task.start_date);
			var e = convert(task.end_date);
			gantt.message("<b>"+task.text +"</b>" + "</br> 시작일 " + s+"일" + "</br> 종료일 " + e +"일");
		}
	});
	gantt.attachEvent("onBeforeTaskChanged", function (id, mode, old_event) {
		var task = gantt.getTask(id);
		if (mode == gantt.config.drag_mode.progress) {
			//if (task.progress < old_event.progress) {
			//	gantt.message("<b>task.text</b>"+ " 작업진행도는 되돌릴 수 없습니다");
			//	return false;
			//}
		}
		return true;
	});

	gantt.attachEvent("onBeforeTaskDrag", function (id, mode) {
		var task = gantt.getTask(id);
		var message = "<b>"+task.text +"</b>"+ " ";

		if (mode == gantt.config.drag_mode.progress) {
			message += "작업 진행도 업데이트";
		} else {
			if (mode == gantt.config.drag_mode.move)
				message += "이동됨";
			else if (mode == gantt.config.drag_mode.resize)
				message += "재설정됨";
		}

		gantt.message(message);
		return true;
	});


	/* 자동 증가 progress
	
	
	var progress_value;
	var dateProgress = function(task){
  		if (+today < +task.start_date) return '예정된 작업';
  		if (+today > +task.end_date) return '완료된 작업';
  		var total_progress = Math.abs(+task.end_date - +task.start_date);
  		var current_progress = Math.abs(+today - task.start_date);
		progress_value = Math.round((current_progress / total_progress)*100)
        return progress_value + '%'; 
     }
	
	var today = new Date();
	
	
	gantt.templates.progress_text = function (start, end, task) {
		if (+today < +task.start_date) return '예정된 작업';
  		if (+today > +task.end_date) return '완료된 작업';
  		var total_progress = Math.abs(+task.end_date - +task.start_date);
  		var current_progress = Math.abs(+today - task.start_date);
		var progress_value = Math.round((current_progress / total_progress)*100)
        return "<span style='text-align:left;'>" + Math.round(task.progress * 100) + "%" + " </span>";        
	};
	*/
	gantt.templates.progress_text = function (start, end, task) {
		console.log(task.progress);
		return "<span style='text-align:left;'>" + Math.round(task.progress * 100) + "% </span>";
	};

	/* 자동 progress 테스트
	var today_marker = gantt.addMarker({      
	    start_date: today,
	    css: "today", 
	    text: "Now",
	});
	next_day() 

	function next_day(){
	 	today = gantt.date.add(today,1,'day');
	  	gantt.render();
	  	document.getElementById('today').innerHTML = 'Current day: ' + gantt.date.date_to_str("%Y/%m/%d")(today);
	  	gantt.getMarker(today_marker).start_date = today;
		gantt.updateMarker(today_marker);    

	}
	*/




	var dateToStr = gantt.date.date_to_str(gantt.config.task_date);
	var today = new Date();
	gantt.addMarker({
		start_date: today,
		text: "오늘",
		title: dateToStr(today)
	});

	/*
	var startPro = ${startDate}
	var start = new Date(startPro.start_date);
	gantt.addMarker({
		start_date: start,
		css: "status_line",
		text: "시작일",
		title: dateToStr(start)
	});

	var endPro = ${startDate}
	var end = new Date(startPro.end_date);
	gantt.addMarker({
		start_date: end,
		text: "종료일",
		title: dateToStr(end)
	});
	*/
	
	var zoomConfig = {
			levels: [
				{
					name:"day",
					scale_height: 40,
					min_column_width:50,
					scales:[
						
						{ unit: "month", step: 1, format: "%Y년 %M월" },
						{ unit: "day", step: 1, format: "%j" }
					]
				},
				{
					name:"quarter",
					scale_height: 50,
					min_column_width:90,
					scales:[
						{unit: "year", step: 1, format: "%Y"},
						{unit: "quarter", step: 1, format: quarterLabel},
						{unit: "month", step: 1, format: "%M"}
					]
				},
				
				{
					name: "month",
					scale_height: 40,
					min_column_width: 30,
					scales: [
						{ unit: "year", step: 1, format: "%Y년" },
						{ unit: "month", step: 1, format: "%M월" }
					]
				},

			]
		};

	function quarterLabel(date) {
		var month = date.getMonth();
		var q_num;

		if (month >= 9) {
			q_num = 4;
		} else if (month >= 6) {
			q_num = 3;
		} else if (month >= 3) {
			q_num = 2;
		} else {
			q_num = 1;
		}

		return q_num + "분기";
	}


	

		gantt.ext.zoom.init(zoomConfig);
		//gantt.ext.zoom.setLevel("month");
		gantt.ext.zoom.attachEvent("onAfterZoom", function(level, config){
			document.querySelector(".gantt_radio[value='" +config.name+ "']").checked = true;
		})

		function zoomIn() {
			gantt.ext.zoom.zoomIn();
		}
		function zoomOut() {
			gantt.ext.zoom.zoomOut()
		}

		var radios = document.getElementsByName("scale");
		for (var i = 0; i < radios.length; i++) {
			radios[i].onclick = function (event) {
				gantt.ext.zoom.setLevel(event.target.value);
			};
		}

	gantt.config.open_tree_initially = true;
	
	gantt.init("gantt_here");
	gantt.parse({
			data: ganttData
		});
	//showMessage('info');

	 var filter_data;
	 var search_box = document.getElementById("search");
	 gantt.attachEvent("onDataRender", function(){
	   search_box = document.getElementById("search");
	 });  

	 function change_detector(){
	 	filter_data = search_box.value;
	 	gantt.refreshData();
	 }

	 function compare_input(id) {
	 	var match = false;
	 	// check children's text
	 	if (gantt.hasChild(id)) {
	 		gantt.eachTask(function(child_object){
	 			if (compare_input(child_object.id, filter_data)) match = true;
	 		}, id);
	 	}  

	 	// check task's text
	 	if (gantt.getTask(id).text.toLowerCase().indexOf(filter_data.toLowerCase()) >= 0)
	 		match = true;

	 return match;
	 }

	 gantt.attachEvent("onBeforeTaskDisplay", function (id, task) {
	 	if (compare_input(id)) {
	 		return true;
	 	}

	 	return false;
	 });

	gantt.createDataProcessor({
			url: "dhtmlxGanttData",
			mode: "POST"
	});
	 

	change_detector();

	
</script>

</body>
</html>