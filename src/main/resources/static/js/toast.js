function callGrid(){
	const grid = new tui.Grid({
		el: document.getElementById('grid'),
		data: {
			api: {
				readData: { url: 'ajax/ajaxDataList.do', method: 'GET' }
			}
		},
		scrollX: false,
		scrollY: false,
		minBodyHeight: 30,
		rowHeaders: ['rowNum'],
		pageOptions: {
			perPage: 10
		},
		columns: [
			{
				header: '이름',
				name: 'user_nm'
			},
			{
				header: '사번',
				name: 'user_num'
			},
			{
				header: '부서',
				name: 'user_dp_nm'
			},
			{
				header: '조',
				name: 'user_work_jo'
			},
			{
				header: '부서코드',
				name: 'user_part1'
			},
			{
				header: '부서2코드',
				name: 'user_part2'
			}
		]
	});
}

/*
const grid = new tui.Grid({
	el: document.getElementById('grid'),
//	data: gridData,
	scrollX: false,
	scrollY: false,
	minBodyHeight: 30,
    rowHeaders: ['rowNum'],
    pageOptions: {
      perPage: 5
    },
	columns: [
		{
			header: '이름',
			name: 'user_nm'
		},
		{
			header: '사번',
			name: 'user_num'
		},
		{
			header: '부서',
			name: 'user_dp_nm'
		},
		{
			header: '조',
			name: 'user_work_jo'
		},
		{
			header: '부서코드',
			name: 'user_part1'
		},
		{
			header: '부서2코드',
			name: 'user_part2'
		}
	]
});
*/