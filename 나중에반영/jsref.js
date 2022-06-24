function readURL(input){
			if(input.files && input.files[0]){
				console.log("이미지 인식!!");
				var filename = input.files[0].name;
				var reader = new FileReader();
				
				/* reader.addEventListener("load", function(e){
					document.getElementById("img").src = e.target.result;
				}); */
				reader.readAsDataURL(input.files[0]);
				showUploadedImages(input);
			}
		}
		
		$('.regiBtn').click(function(){
	        var formData = new FormData();
			var title = $('input[name="title"]').val();
			formData.append("title", title);
			var weather = $('input[name="weather"]:checked').val();
			formData.append("weather", weather);
			var content = $('input[name="content"]').val();
			formData.append("content", content);
			var canReply = $('input:checkbox[id="canReply"]').is(':checked') ? 1 : 0;
			formData.append("canReply", canReply);
			var isSecret = $('input:checkbox[id="isSecret"]').is(':checked') ? 1 : 0;
			formData.append("isSecret",isSecret);
	        var inputFile = $("input[type='file']");
	        var files = inputFile[0].files;
	        if(files.length < 1){
	            alert("업로드할 파일을 선택하지 않으셨습니다.");
	            return;
	        }
	        for (var i = 0; i < files.length; i++) {
	            console.log(files[i]);
	            formData.append("image", files[i]);
	        }
	        $.ajax({
	        	url:"/mydiary/register",
	        	processData:false,
	        	contentType:false,
	        	data:formData,
	        	type:"POST",
	        	dataType:"json",
	        	sucess:function(result){
	        		console.log(result);
	        		alert("글 등록 성공!")
	        	},
	        	error:function(jqXHR, textstatus, errorThrown){
	        		console.log(textstatus);
	        	}
	        })
		})