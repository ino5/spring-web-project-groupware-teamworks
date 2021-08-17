 $(document).ready(function(){
        $("#button1").click(function(){
            var submenu = $(this).next("#scroll");
            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
            if( submenu.is(":visible") ){
            	$('#img1')
                .css({'transform': 'rotate(0deg)'});
                submenu.slideUp("fast");
            }else{
            	$('#img1')
                .css({'transform': 'rotate(90deg)'});
                submenu.slideDown("fast");
            }
        })
        $("#button2").click(function(){
            var submenu = $(this).next("#scroll");
            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
            if( submenu.is(":visible") ){
            	$('#img2')
                .css({'transform': 'rotate(0deg)'});
                submenu.slideUp("fast");
            }else{
            	$('#img2')
                .css({'transform': 'rotate(90deg)'});
                submenu.slideDown("fast"); 	
            }
        })
    });
     $(document).ready(function(){
    	//차트 값 세팅 (데이터 값을 불러와서 형식에 맞게 넣기)
    	var dptData = new Array();
    	$("#test").click(function(){
    	//데이터를 조회하는 통신
			$.ajax({
		        data : {},
		        type : "POST",
		        url : _contextPath+"/admin/memberAllList",
		        contentType : false,
		        processData : false,
		        success : function(data) {
		            //항상 업로드된 파일의 url이 있어야 한다.
		            console.log(data);
		           // barChart(data);
		           var label = new Array();
		           var chartData = new Array();
		       
		          var title = "부서별 사원 수";
		           if(data.length>0){
			           for(var i=0;i<data.length;i++){
			           		label.push(data[i].dpt_name);
			           		chartData.push(data[i].dpt_count);
			           		dptData.push({code:data[i].dpt_code , name :data[i].dpt_name});
			           }
			           barChart(label,chartData,title);
			           
			         /*  1.차트에 들어가는 데이터 형태를 파악하기
			           2.조회한 데이터 확인
			           3.데이터형태에 맞춰서 값 넣어주기
			            label = ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"]
		         		data =   [12, 19, 3, 5, 2, 3] */
		           } 
		        }
	    	});
    	});
    	
    	
    //차트실행 함수 (함수가 실행되면 차트가 그려지도록 만듬)	
	function barChart(label , data,title){
	    // 우선 컨텍스트를 가져옵니다. 
		var ctx1 = document.getElementById("myChart").getContext('2d');
		console.log(dptData);
		/*
		- Chart를 생성하면서, 
		- ctx를 첫번째 argument로 넘겨주고, 
		- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줍니다. 
		*/
		var myChart = new Chart(ctx1, {
		    type: 'bar',
		    data: {
		        labels: label,
		        datasets: [{
		            label: title,
		            data: data,
		            backgroundColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)',
		                'rgba(255, 206, 86, 0.2)',
		                'rgba(75, 192, 192, 0.2)',
		                'rgba(153, 102, 255, 0.2)',
		                'rgba(255, 159, 64, 0.2)'
		            ],
		            borderColor: [
		                'rgba(255,99,132,1)',
		                'rgba(54, 162, 235, 1)',
		                'rgba(255, 206, 86, 1)',
		                'rgba(75, 192, 192, 1)',
		                'rgba(153, 102, 255, 1)',
		                'rgba(255, 159, 64, 1)'
		            ],
		            borderWidth: 1
		        }]
		    },
		    options: {
			    //차트를 누르면 이벤트 발생
			    onClick: function(c,i) {
			    //이벤트를 만들어서 C, i 를 받음
					    e = i[0];
					    //차트 순서 인덱스 
					    var idx = e._index;
					    var url="";
					    if(idx==0){
					    	url="/board/sideboard_list?bd_num=105";
					    }else if(idx==1){
					    	url="/board/sideboard_list?bd_num=104";
					    }else if(idx==2){
					    	url="/board";
					    }else if(idx==3){
					    	url="/board";
					    }else if(idx==4){
					    	url="/board/sideboard_list?bd_num=103";
					    }else if(idx==5){
					    	url="/board";
					    }
			    
					     location.href= _contextPath+url;
					},
			        maintainAspectRatio: true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
			        scales: {
			            yAxes: [{
			                ticks: {
			                    beginAtZero:true
			                }
			            }]
			        }
			    }
			});
		}
    });



function doShow() { 
    if ($('#hide').is(":visible")) { 
        $('#hide').hide();             	
        $('#img3').css({'transform': 'rotate(180deg)'});
        $('#content').css({"width": "100%"}); 
        $('#list_table').css({"width": "1730px"}); 
    } else { 
        $('#hide').show(); 
        $('#img3').css({'transform': 'rotate(0deg)'});
        $('#content').css({"width": "1591.8px"});  
        $('#list_table').css({"width": "1591px"}); 
    } 
} 

function selectAll(selectAll)  {
	  const checkboxes 
	       = document.getElementsByName('check');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked;
	  })
	}