function fnBtnCrud(mode) {
	if(mode == "add") {
		var rowData = [];
			
		grid.appendRow(rowData, {
			at: grid.getRowCount(),
			extendPrevRowSpan: true,
			focus: true,
		});
	}else if(mode == "create") {
		grid.request('createData');
	}else if(mode == "update"){
		grid.request('updateData');
	}else{
		grid.removeCheckedRows();
		grid.request('deleteData');
	}
	window.location.reload();
}



class RowNumberRenderer {
	  constructor(props) {
	    const el = document.createElement('span');
	    
	    this.el = el;
	    this.el.innerHTML = this.getRowNum(props);
	  }

	  getRowNum(props) {
	    const currentPage = props.grid.getPagination()._currentPage;
	    // You can change the number `5` as your perPage option.
	    return Number(props.formattedValue) + (currentPage - 1) * grid.getPagination()._options.itemsPerPage;
	  }

	  getElement() {
	    return this.el;
	  }

	  render(props) {
	    this.el.innerHTML = this.getRowNum(props);
	  }
}

function callGrid(depart){
	var departV = depart;
	grid = new tui.Grid({
		el: document.getElementById('grid'),
		data: {
			api: {
				readData: { url: 'test/testDataList.do', method: 'GET' },
				createData: { url: 'test/createData.do', method: 'POST', contentType: "application/json"},
				updateData: { url: 'test/updateData.do', method: 'POST', contentType: "application/json"},
				modifyData: { url: 'test/modifyData.do', method: 'PUT' },
				deleteData: { url: 'test/deleteData.do', method: 'POST', contentType: "application/json"},
			}
		},
		scrollX: true,
		scrollY: true,
		
		minBodyHeight: 30,
		bodyHeight: 400,
		rowHeaders: [
			{
				type: 'checkbox'
				//renderer: {
				//	type: CheckboxRenderer
				//}
			},
			{
				type: 'rowNum',
				renderer: {
					type: RowNumberRenderer
				}
			}
		],
		pageOptions: {
			perPage: 500,
			useClient: false
		},
		columns: [
			{
				header: 'id',
				name: 'id',
				align: 'center',
				valign: 'center',
				sortingType: 'asc',
		        sortable: true,
				width: '60',
				onBeforeChange(ev) {
					console.log('NAME BEFORE CHANGE: ' + ev.value);
				},
				onAfterChange(ev) {
					console.log('NAME AFTER CHANGE: ' + ev.value);
				},
				editor: 'text'
			},
			{
				header: 'name',
				name: 'name',
				filter: {
					type: 'text',
					showApplyBtn: true,
			        showClearBtn: true
				},
				align: 'center',
				sortingType: 'asc',
		        sortable: true,
				width: '10',
				onBeforeChange(ev) {
					console.log('NUMBER BEFORE CHANGE: ' + ev.value);
				},
				onAfterChange(ev) {
					console.log('NUMBER AFTER CHANGE: ' + ev.value);
				},
				editor: {
					type: CustomTextEditor,
					options: {
						maxLength: 5
					}
				}
			},
			{
				header: 'artist',
				name: 'artist',
				align: 'center',
				onBeforeChange(ev) {
					console.log('DEPARTMENT BEFORE CHANGE: ' + ev.value);
				},
				onAfterChange(ev) {
					console.log('DEPARTMENT AFTER CHANGE: ' + ev.value);
				},
				editor: {
					type: 'text'
				}
			},
			{
				header: 'release',
				name: 'release',
				align: 'center',
				editor: {
					type: 'datePicker',
					options: {
						format: 'yyyy-MM-dd'
					}
				},
				onBeforeChange(ev) {
					console.log('NAME BEFORE CHANGE: ' + ev.value);
				},
				onAfterChange(ev) {
					console.log('NAME AFTER CHANGE: ' + ev.value);
				},
			},
			{
				header: 'type',
				name: 'type',
				align: 'center',
				onBeforeChange(ev) {
					console.log('BUSU BEFORE CHANGE: ' + ev.value);
				},
				onAfterChange(ev) {
					console.log('BUSU AFTER CHANGE: ' + ev.value);
				},
				filter: 'select',
				//formatter: 'listItemText',
				editor: {
					type: 'radio',
					options: {
						listItems: [
							{text: 'Single',	value: 'Single'},
							{text: 'Ep',	value: 'Ep'},
							{text: 'Deluxe',	value: 'Deluxe'},
						]
					}
				},
			},
			{
				header: 'type_cd',
				name: 'type_cd',
				align: 'center',
				filter: 'select',
				onBeforeChange(ev) {
					console.log('PART BEFORE CHANGE: ' + ev.value);
				},
				onAfterChange(ev) {
					console.log('PART AFTER CHANGE: ' + ev.value);
				},
				cotyOptions: {
					useListItemText: true
				},
				width: '150',
				editor: {
					type: 'text'
				}
			},
			{
				header: 'genre',
				name: 'genre',
				align: 'center',
				filter: 'select',
				editor: {
					type: 'text'
					/*
					type: 'select',
					options: {
						listItems: [
							{text:'POP', value:'POP'},
							{text:'HIPHOP', value:'HIPHOP'},
							{text:'ROCK', value:'ROCK'}
						]
					}
					*/
				}
			},
			{
				header: 'price',
				name: 'price',
				align: 'center',
				editor: {
					type: 'text'
				}
			}
		],
		summary: {
			
			height: 50,
			position: 'bottom',
			columnContent: {
				
				price: {
					template: function(valueMap) {
						return `MAX: ${valueMap.max}	MIN: ${valueMap.min}<br>TOTAL: ${valueMap.sum}	AVG: ${valueMap.avg.toFixed(2)}`;
					}
				},
				id: {
					template: function(typeFilter) {
						return `TOTAL: ${typeFilter.filtered.cnt}`;
					}
				}
			},
		},
		columnOptions: {
		    frozenCount: 2, // 3개의 컬럼을 고정하고
		    frozenBorderWidth: 5, // 고정 컬럼의 경계선 너비를 2px로 한다.
		    minWidth: 150
		}
	});
}



Array.prototype.forEach.call(document.querySelectorAll('.btn-theme'), el => {
	el.addEventListener('click', ev => {
		const preset = ev.target.getAttribute('data-preset');
		tui.Grid.applyTheme(preset);
	});
});

document.querySelector('.btn-custom').addEventListener('click', () =>{
	const options = eval(`(${document.getElementById('custom-text').value})`);
	tui.Grid.applyTheme('default', options);
});

class CustomTextEditor {
	constructor(props) {
		const el = document.createElement('input');
		const {maxLength} = props.columnInfo.editor.options;
		
		el.type = 'text';
		el.maxLength = maxLength;
		el.value = String(props.value);
		this.el = el;
	}
	
	getElement() {
		return this.el;
	}
	
	getValue() {
		return this.el.value;
	}
	
	mounted() {
		this.el.select();
	}
}

class CustomSliderRenderer {
	constructor(props) {
		const el = document.createElement('input');
		const {min, max} = props.columnInfo.renderer.option;
		
		el.addEventListener('mousedown', (ev) => {
			ev.stopPropagation();
		});
		
		el.type = 'range';
		el.min = String(min);
		el.max = String(max);
		el.disabled = false;
		
		this.el = el;
		this.render(props);
		
	}
	
	getElement() {
		return this.el;
	}
	
	
	render(props) {
		this.el.value = String(props.value); 
	}
}

class CheckboxRenderer {
    constructor(props) {
      const { grid, rowKey } = props;

      const label = document.createElement('label');
      label.className = 'checkbox';
      label.setAttribute('for', String(rowKey));

      const hiddenInput = document.createElement('input');
      hiddenInput.className = 'hidden-input';
      hiddenInput.id = String(rowKey);

      const customInput = document.createElement('span');
      customInput.className = 'custom-input';

      label.appendChild(hiddenInput);
      label.appendChild(customInput);

      hiddenInput.type = 'checkbox';
      hiddenInput.addEventListener('change', () => {
        if (hiddenInput.checked) {
          grid.check(rowKey);
        } else {
          grid.uncheck(rowKey);
        }
      });
      
      hiddenInput.addEventListener('change', () => {
          if (hiddenInput.checked) {
            grid.check(rowKey);
          } else {
            grid.uncheck(rowKey);
          }
        });

      this.el = label;

      this.render(props);
    }

    getElement() {
      return this.el;
    }

    render(props) {
      const hiddenInput = this.el.querySelector('.hidden-input');
      const checked = Boolean(props.value);

      hiddenInput.checked = checked;
    }
 }
