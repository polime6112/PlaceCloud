/**
 * 이미지 업로드 기능 jquery 코드
 */
 
$(document).ready(function() {
			function validateImages(files){
				var maxSize = 10 * 1024 * 1024; // 10 MB 
				var allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i; 
				// 허용된 확장자 정규식 (jpg, jpeg, png, gif)
				
				if(files.length > 3) { // 파일 개수 제한
					alert("파일은 최대 3개만 가능합니다.");
					return false;
				}
				
				for(var i = 0; i < files.length; i++) {
					console.log(files[i]);
					var fileName = files[i].name; // 파일 이름
					var fileSize = files[i].size; // 파일 크기
					
					// 파일 크기가 설정 크기보다 크면
					if (fileSize > maxSize) {
						alert("파일의 최대 크기는 10MB입니다.");
						return false;
					}
					
					// regExp.exec(string) : 지정된 문자열에서 정규식을 사용하여 일치 항목 확인
					// 지정된 문자열이 없는 경우 true를 리턴
			        if(!allowedExtensions.exec(fileName)) {
			            alert("이 파일은 업로드할 수 없습니다. jpg, jpeg, png, gif파일만 가능합니다."); // 알림 표시
			            return false;
			        }
				}

				return true; // 모든 조건을 만족하면 true 리턴
			} // end validateImage()
			
			// 파일을 끌어다 놓을 때(drag&drop)
			// 브라우저가 파일을 자동으로 열어주는 기능을 막음
			$('.image-drop').on('dragenter dragover', function(event){
				event.preventDefault();
				console.log('drag 테스트');
			}); 
			
			$('.image-drop').on('drop', function(event){
				event.preventDefault();
				console.log('drop 테스트');
				
				$('.imageVOImg-list').empty(); // 기존 이미지 vo 초기화

				// 드래그한 파일 정보를 갖고 있는 객체
				var files = event.originalEvent.dataTransfer.files;
				console.log(files);
				
				if(!validateImages(files)) { 
					return;
				}
				
				// Ajax를 이용하여 서버로 파일을 업로드
				// multipart/form-data 타입으로 파일을 업로드하는 객체
				var formData = new FormData();

				for(var i = 0; i < files.length; i++) {
					formData.append("files", files[i]); 
				}
						
				$.ajax({
					type : 'post', 
					url : '../image', 
					data : formData,
					processData : false,
					contentType : false,
					success : function(data) {
						console.log(data);
						var list = '';
						$(data).each(function(){
							// this : 컬렉션의 각 인덱스 데이터를 의미
							console.log(this);
						  	var imageVO = this; // imageVO 저장
						  	// encodeURIComponent() : 문자열에 포함된 특수 기호를 UTF-8로 
						  	// 인코딩하여 이스케이프시퀀스로 변경하는 함수 
							var imagePath = encodeURIComponent(this.imagePath);
							
							// input 태그 생성 
							// - type = hidden
							// - name = imageVO
							// - data-chgName = imageVO.imageChgName
							var input = $('<input>').attr('type', 'hidden')
								.attr('name', 'imageVO')
								.attr('data-chgName', imageVO.imageChgName);
							
							// imageVO를 JSON 데이터로 변경
							// - object 형태는 데이터 인식 불가능
							input.val(JSON.stringify(imageVO));
							
				       		// div에 input 태그 추가
				        	$('.imageVOImg-list').append(input);
						  	
						    // display() 메서드에서 이미지 호출을 위한 문자열 구성
						    list += '<div class="image_item" data-chgName="'+ this.imageChgName +'">'
						    	+ '<pre>'
						    	+ '<input type="hidden" id="imagePath" value="'+ this.imagePath +'">'
						    	+ '<input type="hidden" id="imageChgName" value="'+ imageVO.imageChgName +'">'
						    	+ '<input type="hidden" id="imageExtension" value="'+ imageVO.imageExtension +'">'
						        + '<a href="../image/display?imagePath=' + imagePath + '&imageChgName='
						        + imageVO.imageChgName + "&imageExtension=" + imageVO.imageExtension
						        + '" target="_blank">'
						        + '<img width="100px" height="100px" src="../image/display?imagePath=' 
						        + imagePath + '&imageChgName='
						        + 't_' + imageVO.imageChgName 
						        + "&imageExtension=" + imageVO.imageExtension
						        + '" />'
						        + '</a>'
						        + '<button class="image_delete" >x</button>'
						        + '</pre>'
						        + '</div>';
						}); // end each()

						// list 문자열 image-list div 태그에 적용
						$('.image-list').html(list);
					} // end success
				
				}); // end $.ajax()
				
			}); // end image-drop()
						
			
			$('.image-list').on('click', '.image_item .image_delete', function(){
				console.log(this);
				if(!confirm('삭제하시겠습니까?')) {
					return;
				}
				var imagePath = $(this).prevAll('#imagePath').val();
				var imageChgName = $(this).prevAll('#imageChgName').val();
				var imageExtension= $(this).prevAll('#imageExtension').val();
				console.log(imagePath);
				
				// ajax 요청
				$.ajax({
					type : 'POST', 
					url : '../image/delete', 
					data : {
						imagePath : imagePath, 
						imageChgName : imageChgName,
						imageExtension: imageExtension
					}, 
					success : function(result) {
						console.log(result);
						if(result == 1) {
							$('.image-list').find('div')
						    .filter(function() {
						    	// data-chgName이 선택된 파일 이름과 같은 경우
						        return $(this).attr('data-chgName') === imageChgName;
						    })
						    .remove();
						    
						    $('.imageVOImg-list').find('input')
						    .filter(function() {
						    	// data-chgName이 삭제 선택된 파일 이름과 같은 경우
						        return $(this).attr('data-chgName') === imageChgName;
						    })
						    .remove();

						}

					}
				}); // end ajax()
				
			}); // end image-list.on()
			
		}); // end document