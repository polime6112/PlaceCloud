/**
 * 이미지 업로드 기능 jQuery 코드
 */

$(document).ready(function(){
    // 파일 객체를 배열로 받아서 검증하는 함수
    function validateImages(files){
        let maxSize = 10 * 1024 * 1024; // 10 MB 
        let allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i; 
        // 허용된 확장자 목록 (jpg, jpeg, png, gif)
        
        if(files.length > 1) { // 파일 개수 제한
            alert("파일은 최대 1개만 업로드할 수 있습니다.");
            return false;
        }
        
        for(let i = 0; i < files.length; i++) {
            console.log(files);
            let fileName = files[i].name; // 파일 이름
            let fileSize = files[i].size; // 파일 크기
            
            // 파일 크기가 최대 크기보다 크면
            if (fileSize > maxSize) {
                alert("파일의 최대 크기는 10MB입니다.");
                return false;
            }
            
            // 확장자가 허용되지 않은 형식일 경우
            if(!allowedExtensions.exec(fileName)) {
                alert("업로드할 수 없는 파일 형식입니다. jpg, jpeg, png, gif 파일만 업로드 가능합니다.");
                return false;
            }
        }

        return true; // 모든 조건이 충족되면 true 반환
    }
    
    // 파일을 드래그 앤 드롭으로 가져오는 기능
    $('.imageUpload').on('dragenter dragover', function(event){
        event.preventDefault();
        console.log('drag 이벤트 발생');
    }); 
    
    $('.imageUpload').on('drop', function(event){
        event.preventDefault();
        console.log('drop 이벤트 발생');
        
        $('.imageList').empty(); // 기존 이미지 리스트 초기화
                        
        // 드래그된 파일 리스트
        let files = event.originalEvent.dataTransfer.files;
        console.log(files);
        
        if(!validateImages(files)) { 
            return;
        }
        
        // Ajax를 사용하여 서버로 파일을 업로드
        let formData = new FormData();

        for(let i = 0; i < files.length; i++) {
            formData.append("file", files[i]); 
        }
                
        $.ajax({
            type: 'post', 
            url: 'placeImage/imageInsert', 
            data: formData,
            processData: false,
            contentType: false,
            success: function(data) {
                try {
                    if (typeof data === 'string') {
                        data = JSON.parse(data); // JSON 문자열을 파싱
                    }
                } catch (e) {
                    console.error("Invalid JSON format", e);
                    alert("서버로부터 올바르지 않은 응답이 수신되었습니다.");
                    return;
                }

                console.log(data);
                let list = '';
                $.each(data, function(index, attachImage){
                    // attachImage: 현재의 attachImage 객체
                    console.log(attachImage);
                    let attachPath = encodeURIComponent(attachImage.attachPath);
                    
                    let input = $('<input>').attr('type', 'hidden')
                        .attr('name', 'attachImage')
                        .attr('data-chgName', attachImage.attachChgName)
                        .val(JSON.stringify(attachImage));
                    
                    $('.imageList').append(input);
                    
                    // 이미지 표시를 위한 HTML 생성
                    list += '<div class="imageItem" data-chgName="'+ attachImage.attachChgName +'">'
                        + '<pre>'
                        + '<input type="hidden" id="attachPath" value="'+ attachImage.attachPath +'">'
                        + '<input type="hidden" id="attachChgName" value="'+ attachImage.attachChgName +'">'
                        + '<input type="hidden" id="attachExtension" value="'+ attachImage.attachExtension +'">'
                        + '<a href="placecloud/placeImage/image/display?attachPath=' + attachPath + '&attachChgName='
                        + attachImage.attachChgName + "&attachExtension=" + attachImage.attachExtension
                        + '" target="_blank">'
                        + '<img width="100px" height="100px" src="placecloud/placeImage/image/display?attachPath=' 
                        + attachPath + '&attachChgName='
                        + 't_' + attachImage.attachChgName 
                        + "&attachExtension=" + attachImage.attachExtension
                        + '" />'
                        + '</a>'
                        + '<button class="imageDelete">x</button>'
                        + '</pre>'
                        + '</div>';
                }); 

                $('.imageList').html(list);
            }
        
        });
        
    }); 
    
    $('.imageList').on('click', '.imageItem .imageDelete', function(){
        console.log(this);
        if(!confirm('삭제하시겠습니까?')) {
            return;
        }
        let attachPath = $(this).prevAll('#attachPath').val();
        let attachChgName = $(this).prevAll('#attachChgName').val();
        let attachExtension= $(this).prevAll('#attachExtension').val();
        console.log(attachPath);
        
        // ajax 요청
        $.ajax({
            type: 'POST', 
            url: 'placeImage/imageDelete', 
            data: {
                attachPath: attachPath, 
                attachChgName: attachChgName,
                attachExtension: attachExtension
            }, 
            success: function(result) {
                console.log(result);
                if(result == 1) {
                    $('.imageList').find('div')
                    .filter(function() {
                        return $(this).attr('data-chgName') === attachChgName;
                    })
                    .remove();
                    
                    $('.imageList').find('input')
                    .filter(function() {
                        return $(this).attr('data-chgName') === attachChgName;
                    })
                    .remove();

                }

            }
        });
        
    }); 
    
});
