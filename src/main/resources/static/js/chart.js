function chart(){
	var container = document.getElementById('chart-area');
	var data = {
	    categories: ['June'],
	    series: [
	        {
	            name: 'type',
	            data: [grid.findRows({'type':'Single'}).length]
	        },
	        {
	            name: 'Income',
	            data: [8000]
	        }
	    ]
	};
	var options = {
	    chart: {
	        width: 460,
	        height: 350,
	        title: 'Monthly Revenue',
	        format: '1,000'
	    },
	    yAxis: {
	        title: 'Month'
	    },
	    xAxis: {
	        title: 'Amount',
	        min: 0,
	        max: 9000,
	        suffix: '$'
	    },
	     series: {
	         showLabel: true
	     }
	};
	var theme = {
	    series: {
	        colors: [
	            '#83b14e', '#458a3f', '#295ba0', '#2a4175', '#289399',
	            '#289399', '#617178', '#8a9a9a', '#516f7d', '#dddddd'
	        ]
	    }
	};

	// For apply theme

	// tui.chart.registerTheme('myTheme', theme);
	// options.theme = 'myTheme';


	tui.chart.barChart(container, data, options);
}