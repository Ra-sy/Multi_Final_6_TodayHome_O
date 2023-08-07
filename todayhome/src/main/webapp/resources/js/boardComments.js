$(document).ready(function () {
    // 페이지 로드 시 댓글 목록 가져오기
    getComments();
    cancelEdit();
    // 댓글 등록 폼 제출 이벤트 처리
    $('#commentForm').submit(function (e) {
        e.preventDefault();
        var comment = $('#commentInput').val();
        console.log('comment', comment);

        // if (comment.trim() === '') {
        //   alert('댓글 내용을 입력해주세요.'); // 입력하지 않았을 때 에러 메시지 출력
        //   return;
        // }

        // 댓글 등록 AJAX 호출
        addComment(comment);
    });
});

// 댓글 수정 폼 제출 이벤트 처리
$('.editCommentForm').submit(function (e) {
    e.preventDefault();
    var num = $('#editnum').val();
    var content = $(`.editCommentInput[data-num=${num}]`).val();
    updateComment(num, content);
    console.log('updatecomment', comment);
});


// 댓글 목록 가져오기
function getComments() {

    console.log('getComments()...');
    $.ajax({
        type: 'get',
        url: 'getcomments?brdNum=' + num,
        success: function (data) {
            console.log(data);
            // 댓글 목록 출력 처리
            var commentList = $('#getCommentsList');
            commentList.empty();

            if (data.length > 0) {
                $.each(data, function (index, comment) {
                    var commentItem =
                        '<li>' +
                        '<div class="commentProfileSet">' +
                        '<img class="commentProfileImg" src="../../../../resources/uploadimg/' + comment.mbrImg + '">' +
                        '<span>' + comment.nickname + '</span>' +
                        '</div>' +
                        '<p>' + comment.content + '</p>' +
                        '<div class="editCommentForm" style="display: none" data-num="' + comment.num + '">' +
                        '<input type="hidden" id="editnum" value="' + comment.num +'">' +
                        '<input type="text" class="editCommentInput" data-num="' + comment.num + '">' +
                        '<button onclick="updateComment()">수정완료</button>' +
                        '<button type="button" onclick="cancelEdit(' + comment.num + ')">취소</button>' +
                        '</div>';

                    if (comment.mbrNum == usrMnum) {
                        commentItem +=
                            '<button class="editBtn" onclick="showEditForm(' + comment.num + ', \'' + comment.content + '\')">수정</button>' +
                            '<button class="deleteBtn" onclick="deleteComment(' + comment.num + ')">삭제</button>';
                    }

                    commentItem += '</li>';

                    commentList.append(commentItem);

                });//end each
            } else {
                commentList.append('<li>댓글이 없습니다.</li>');
            }

            //end if
        }//end success
    });//end ajax
}//end getComments


// 댓글 등록 AJAX 호출
function addComment(content) {

    var commentData = {
        brdNum: num,
        mbrNum: usrMnum,
        nickname: nickname,
        content: content
    };

    if (commentData.mbrNum != 0) {
        if (commentData.content == '') {
            alert('댓글 내용을 입력해주세요.'); // 입력하지 않았을 때 에러 메시지 출력
            return;
        }

        $.ajax({
            type: 'get',
            url: 'addcomments',
            contentType: 'application/json',
            data: commentData,
            success: function (data) {
                console.log("data:", data);
                // 댓글 등록 후 처리

                console.log("hi",data.cnt)

                $('.bottom-comments-count').text(data.cnt);
                $('.comments-cnt').text(data.cnt);

                getComments();
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    } else {
        alert('로그인 후 이용할 수 있습니다.');
        location.href = '/login';
    }
}//end addComment

// 댓글 수정 폼 보여주기
function showEditForm(num, content) {
    console.log('showEditForm() called. num:', num, 'content:', content);

    if (confirm('수정하시겠습니까?') == true) {
        $('#editnum').val(num);
        $(`.editCommentInput[data-num=${num}]`).val(content);
        $(`.editCommentForm[data-num=${num}]`).css("display","block");
    }
}

// 댓글 수정 폼 숨기기
function cancelEdit(num) {
    $(`.editCommentForm[data-num=${num}]`).css("display","none");
}


// 댓글 수정 AJAX 호출
function updateComment() {
    console.log('updateComment()...');
    let num = $('#editnum').val();
    let content = $(`.editCommentInput[data-num=${num}]`).val();
    console.log('num...', num);
    console.log('content...', content);

    var commentData = {
        num: num,
        content: content
    };

    $.ajax({
        type: 'get',
        url: 'updatecomments',
        contentType: 'application/json',
        data: commentData,
        success: function (data) {
            console.log("data:", data);

            // 댓글 수정 후 처리

            cancelEdit(); // 수정 폼 숨기기
            getComments();
        },
        error: function (xhr, status, error) {
            console.log(error);
        }
    });


}//end updateComment

// 댓글 삭제 AJAX 호출
function deleteComment(cmtNum) {
    console.log('deleteComment()...', cmtNum);

    if (confirm('삭제하시겠습니까?') == true) {
        $.ajax({
            type: 'get',
            data:{
              num : cmtNum,
              brdNum : num
            },
            url: 'deletecomments',
            success: function (data) {
                console.log("data:", data);

                $('.bottom-comments-count').text(data.cnt);
                $('.comments-cnt').text(data.cnt);
                // 댓글 삭제 후 처리
                getComments();
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }
}//end deleteComment
