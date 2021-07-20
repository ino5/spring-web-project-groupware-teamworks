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
        //차트 초기화
    	lineChart([],[]);
    	
    	//차트 값 세팅 (데이터 값을 불러와서 형식에 맞게 넣기)
    	$("#test").click(function(){
    		var label =  ["월","화","수","목","금","토","일"];
    		var data = [2, 3, 5, 7, 11, 13, 17];

    		lineChart(label, data);
    	});
      //선 차트입니다.
        function lineChart(label , data){
        	var data = {
        	        labels:label,
        	        datasets: [
        	            {
        	                label: "",
        	                fillColor: "rgba(220,220,220,0.5)",
        	                strokeColor: "rgba(220,220,220,1)",
        	                pointColor: "rgba(220,220,220,1)",
        	                pointStrokeColor: "#ffff",
        	                pointHighlightFill: "#ffff",
        	                pointHighlightStroke: "rgba(189,189,189,2)",
        	                data: data
        	            },
        	            {
        	                label: "",
        	                fillColor: "rgba(151,187,205,0.2)",
        	                strokeColor: "rgba(151,187,205,1)",
        	                pointColor: "rgba(151,187,205,1)",
        	                pointStrokeColor: "#fff",
        	                pointHighlightFill: "#fff",
        	                pointHighlightStroke: "rgba(151,187,205,1)",
        	                data: [0, 1, 1, 2, 3, 5, 8]
        	            }
        	        ]
        	    };
        	    var ctx = document.getElementById("lineCanvas").getContext("2d");
        	    var options = { };
        	    var lineChart = new Chart(ctx).Line(data, options);
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