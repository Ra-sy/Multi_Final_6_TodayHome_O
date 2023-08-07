(function() {
    const app = {

        data: {
            num, //현재 페이지 글 번호
            brdMnum, //현재 페이지 글 작성자 회원 번호
            usrMnum//현재 로그인 회원 번호
        },

        fvClick(){
            if(usrMnum != 0){
                $.ajax({
                    url : '/bJsonSelectOneFvClick',
                    data : JSON.stringify(this.data),
                    contentType : 'application/json; charset=utf-8',
                    method : 'POST',
                    success: function(resp){
                        console.log(resp);

                        if(resp.favorYn === 'Y'){
                            document.querySelector(".sticky-btn.favor-btn").classList.add("on");
                            document.querySelector(".sticky-counter.favor-cnt").textContent = resp.favorCnt
                            document.querySelector(".bottom-like-count").textContent = resp.favorCnt
                        }
                        else {
                            document.querySelector(".sticky-btn.favor-btn").classList.remove("on");
                            document.querySelector(".sticky-counter.favor-cnt").textContent = resp.favorCnt
                            document.querySelector(".bottom-like-count").textContent = resp.favorCnt
                        }

                    },
                    error: function(xhr, status, error){
                        console.log('error');
                    }
                });
            }
            else{
                alert('로그인 후 이용할 수 있습니다.');
                location.href='/login';
            }
        },

        flwClick(){
            if(usrMnum != 0){
                $.ajax({
                    url : '/bJsonSelectOneFlwClick',
                    data : JSON.stringify(this.data),
                    contentType : 'application/json; charset=utf-8',
                    method : 'POST',
                    success: function(resp){
                        console.log(resp);

                        if(resp === 'Y'){
                            document.querySelector(".btn-follow.top").classList.add("on");
                            document.querySelector(".btn-follow.bottom").classList.add("on");
                        }
                        else{
                            document.querySelector(".btn-follow.top").classList.remove("on");
                            document.querySelector(".btn-follow.bottom").classList.remove("on");
                        }

                    },
                    error: function(xhr, status, error){
                        console.log('error');
                    }
                });
            }
            else{
                alert('로그인 후 이용할 수 있습니다.');
                location.href='/login';
            }
        },

        cmtClick(){
            location.href="#comments"
        },

        topClick(){
            location.href=""
        },

        delClick(){
            let flag = confirm('삭제하시겠습니까?');

            if(flag == true){
                $.ajax({
                    url : '/bJsonDelete',
                    data : JSON.stringify(this.data),
                    contentType : 'application/json; charset=utf-8',
                    method : 'POST',
                    success: function(resp){
                        console.log(resp);

                        let url = resp.url;
                        location.href = url;
                    },
                    error: function(xhr, status, error){
                        console.log('error');
                    }
                });
            }
        },

        updClick(){
            let flag = confirm('수정하시겠습니까?');

            if(flag == true){

                location.href = '../bUpdate/' + this.data.num;
            }
        },

        eventListener() {
            $(".favor-btn").on("click", () => {
                this.fvClick();
            })

            $(".btn-follow").on("click", () => {
                this.flwClick();
            })

            $(".comments-btn").on("click", () => {
                this.cmtClick();
            })

            $(".top-btn").on("click", () => {
                this.topClick();
            })

            $(".del-btn").on("click", () => {
                this.delClick();
            })

            $(".upd-btn").on("click", () => {
                this.updClick();
            })
        }
    };

    window.onload = function() {

        app.eventListener();
    }

})();