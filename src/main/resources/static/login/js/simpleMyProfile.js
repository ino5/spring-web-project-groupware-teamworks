//이미지 미리보기
$('#multipartFile').on('change',readInputMyPhoto);

function readInputMyPhoto(e) {
	$('#image_preview').empty();
	
	let file = e.target.files[0];
	var reader = new FileReader();
    reader.onload = function(e){
    	var html = `<img id="my_photo" src=${e.target.result} data-file=${file.name} />`;
        $('#image_preview').append(html);
    };
    reader.readAsDataURL(file);		
}