var ckeditor_config = {
    resize_enaleb : false,
    enterMode : CKEDITOR.ENTER_BR,
    shiftEnterMode : CKEDITOR.ENTER_P,
    filebrowserUploadUrl : "/bInsertCKEditor",
    filebrowserImageUploadUrl : "/bInsertCKEditor",
    height: "400px",
};

(function(){
    const app = {
        showAdditionalForm() {
            var selectType = document.getElementById("boardNo");
            var additionalForm1 = document.getElementById("additionalForm1");
            var additionalForm2 = document.getElementById("additionalForm2");
            var additionalForm3 = document.getElementById("additionalForm3");
            var additionalForm4 = document.getElementById("additionalForm4");

            additionalForm1.style.display = "none";
            additionalForm2.style.display = "none";
            additionalForm3.style.display = "none";
            additionalForm4.style.display = "none";

            if (selectType.value === "1") {
                additionalForm1.style.display = "block";
            }
            if (selectType.value === "2"){
                additionalForm2.style.display = "block";
            }
            if (selectType.value === "3"){
                additionalForm3.style.display = "block";
            }
            if (selectType.value === "4"){
                additionalForm4.style.display = "block";
            }
        },

        checkEssentialInput(e){
                if($('#boardNo').val() ==''){
                    alert('게시판을 선택해주십시오.')
                    $('#boardNo').focus();
                    e.preventDefault();
                    return false;
                }
                if($('#boardNo').val() == 1){
                    if($('#type').val() == '' || $('#familyType').val() == '' ||
                        $('#workingArea').val() == '' || $('#worker').val() == ''){
                        alert('필수 입력사항을 입력해주십시오.');
                        $('#type').focus();
                        e.preventDefault();
                        return false;
                    }
                }
                if($('#boardNo').val() == 2){
                    if($('#livingtype').val() == ''){
                        alert('필수 입력사항을 입력해주십시오.');
                        $('#livingtype').focus();
                        e.preventDefault();
                        return false;
                    }
                }
                if($('#boardNo').val() == 3){
                    if($('#cooktype').val() == ''){
                        alert('필수 입력사항을 입력해주십시오.');
                        $('#cooktype').focus();
                        e.preventDefault();
                        return false;
                    }
                }
                if($('#boardNo').val() == 4){
                    if($('#dailytype').val() == '') {
                        alert('필수 입력사항을 입력해주십시오.');
                        $('#dailytype').focus();
                        e.preventDefault();
                        return false;
                    }
                }
                if($('#title').val() ==''){
                    alert('제목을 입력해주십시오.')
                    $('#title').focus();
                    e.preventDefault();
                    return false;
                }
                if($('#thumbFile').val() ==''){
                    alert('썸네일 이미지를 선택해주십시오.')
                    $('#thumbFile').focus();
                    e.preventDefault();
                    return false;
                }
                if(CKEDITOR.instances.content.getData() ==''
                    || CKEDITOR.instances.content.getData().length ==0){
                    alert('내용을 입력해주십시오.');
                    $('#content').focus()
                    e.preventDefault();
                    return false;
                }

        },

        eventListener() {
            $("#boardNo").on("change", () => {
                this.showAdditionalForm();
            })
            $("#updateForm").on("submit",(e) => {
                return this.checkEssentialInput(e);
            })
        }
    };

    window.onload = function (){
        app.showAdditionalForm();
        app.eventListener();
    }

})();