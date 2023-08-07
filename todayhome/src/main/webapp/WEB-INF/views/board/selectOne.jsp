<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>${boardModel.title} | todayhome</title>
    <link rel="stylesheet" href="../resources/css/boardSelectOne.css">
    <link rel="stylesheet" href="../resources/css/boardSelectOneBtn.css">
    <link rel="stylesheet" href="../resources/css/boardSelectOneComments.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script>
        let num = <c:out value="${boardModel.num}"/>; //현재 페이지 글 번호
        let brdMnum = <c:out value="${boardModel.brdMnum}"/>; //현재 페이지 글 작성자 회원 번호
        let usrMnum = <c:out value="${boardModel.usrMnum}"/>; //현재 로그인 회원 번호
		let nickname = `<c:out value="${currMbr.nickname}"/>`;
    </script>
<script src="../../../resources/js/boardComments.js"></script>
</head>
<body>
<div class="fixed-menu">
<jsp:include page="../topMenu.jsp">
    <jsp:param name="usrImg" value="${currMbr.img}"/>
</jsp:include>
</div>
<div id="wholeContent">
    <div class="main-img" id="main-img">
        <img src="../resources/uploadimg/${boardModel.imgThumb}">
    </div>
    <div class="contents-wrap">

        <div class="topToBottom">
            <h1 class="header-title">${boardModel.title}</h1>

            <div class="top-info">
                <div class="top-info-profileImg">
                    <img src="../resources/uploadimg/${boardModel.mbrImg}">
                </div>
                <div class="top-info-nameTime">
                    <div>${boardModel.mbrNickname}</div>
                    <div>${elapsedTime}</div>
                </div>
                <c:if test="${boardModel.brdMnum ne boardModel.usrMnum}">
                    <div class="top-info-follow">
                        <button class="btn-follow top <c:if test="${followYn == 'Y'}">on</c:if>"></button>
                    </div>
                </c:if>
            </div>

            <c:if test="${boardModel.boardNo == 1}">
                <div class="sub-info">
                    <div class="sub-info-overview">
                        <c:if test="${not empty boardModel.type}">
                            <div class="sub-info-overview-type">
                                <div class="sub-info-overview-icon">
                                    <svg class="icon" aria-label="공간" width="38" height="38" viewBox="0 0 38 38"
                                         preserveAspectRatio="xMidYMid meet">
                                        <g fill="none" fill-rule="evenodd">
                                            <path d="M0 0h38v38H0z"></path>
                                            <rect width="19.53" height="23.75" x="3.43" y="7.13" fill="#FFF" stroke="#525B61" rx="2.38"></rect>
                                            <rect width="3.17" height="3.17" x="8.18" y="17.42" stroke="#525B61" rx="1.27"></rect>
                                            <rect width="3.17" height="3.17" x="8.18" y="11.08" stroke="#525B61" rx="1.27"></rect>
                                            <rect width="3.17" height="3.17" x="8.18" y="23.75" stroke="#525B61" rx="1.27"></rect>
                                            <rect width="3.17" height="3.17" x="15.31" y="17.42" stroke="#525B61" rx="1.27"></rect>
                                            <rect width="3.17" height="3.17" x="15.31" y="11.08" stroke="#525B61" rx="1.27"></rect>
                                            <rect width="3.17" height="3.17" x="15.31" y="23.75" stroke="#525B61" rx="1.27"></rect>
                                            <rect width="8.44" height="8.44" x="26.39" y="19" fill="#EAEBEF" stroke="#525B61" rx="4.22"></rect>
                                            <rect width="1.58" height="4.22" x="29.56" y="27" fill="#525B61" rx=".79"></rect>
                                        </g>
                                    </svg>
                                </div>
                                <div class="sub-info-overview-text">
                                    <c:choose>
                                        <c:when test="${boardModel.type eq 'oneroom'}">원룸&오피스텔</c:when>
                                        <c:when test="${boardModel.type eq 'apartment'}">아파트</c:when>
                                        <c:when test="${boardModel.type eq 'villa'}">빌라</c:when>
                                        <c:when test="${boardModel.type eq 'house'}">단독주택</c:when>
                                        <c:when test="${boardModel.type eq 'office'}">사무공간</c:when>
                                        <c:when test="${boardModel.type eq 'commercial'}">상업공간</c:when>
                                        <c:when test="${boardModel.type eq 'etc'}">기타</c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty boardModel.sqft}">
                            <div class="sub-info-overview-type">
                                <div class="sub-info-overview-icon">
                                    <svg class="icon" aria-label="평수" width="38" height="38" viewBox="0 0 38 38"
                                         preserveAspectRatio="xMidYMid meet">
                                        <g fill="none" fill-rule="evenodd">
                                            <path d="M0 0h38v38H0z"></path>
                                            <rect width="26.92" height="23.75" x="5.54" y="7.13" fill="#FFF" stroke="#525B61"
                                                  rx="2.38"></rect>
                                            <path fill="#EAEBEF" fill-rule="nonzero"
                                                  d="M8 7.5h8v23H8a2 2 0 01-2-2v-19c0-1.1.9-2 2-2z"></path>
                                            <rect width="8.44" height="1" x="5.28" y="20" fill="#525B61" rx=".5"></rect>
                                            <rect width="10.56" height="1" x="22.17" y="13.72" fill="#525B61" rx=".5"></rect>
                                            <rect width="1" height="5.28" x="9.5" y="15.5" fill="#525B61" rx=".5"></rect>
                                            <rect width="1" height="5.28" x="25.33" y="14" fill="#525B61" rx=".5"></rect>
                                            <rect width="1" height="7.39" x="25.33" y="24" fill="#525B61" rx=".5"></rect>
                                            <rect width="1" height="24" x="15.83" y="7" fill="#525B61" rx=".5"></rect>
                                        </g>
                                    </svg>
                                </div>
                                <div class="sub-info-overview-text">
                                    <c:choose>
                                        <c:when test="${boardModel.sqft eq 'sqft9'}">0~9평</c:when>
                                        <c:when test="${boardModel.sqft eq 'sqft10'}">10평대</c:when>
                                        <c:when test="${boardModel.sqft eq 'sqft20'}">20평대</c:when>
                                        <c:when test="${boardModel.sqft eq 'sqft30'}">30평대</c:when>
                                        <c:when test="${boardModel.sqft eq 'sqft40'}">40평대</c:when>
                                        <c:when test="${boardModel.sqft eq 'sqft50'}">50평대</c:when>
                                        <c:when test="${boardModel.sqft eq 'sqft60'}">60평대 이상</c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty boardModel.workingArea}">
                            <div class="sub-info-overview-type">
                                <div class="sub-info-overview-icon">
                                    <svg class="icon" aria-label="분야" height="38" width="38" viewBox="0 0 38 38"
                                         preserveAspectRatio="xMidYMid meet">
                                        <g fill-rule="evenodd" fill="none">
                                            <path d="M0 0h38v38H0z"></path>
                                            <g transform="translate(4.75 4.75)">
                                                <path d="M15.05 13.2c0 .67-.42 1.3-1.07 1.58l-2.07 1.05a3.2 3.2 0 00-1.85 3.87l.85 3.7c.14.44.16.92.06 1.37v.02a2.93 2.93 0 01-2.88 2.2H7.8a2.93 2.93 0 01-2.88-2.2c-.1-.46-.08-.94.06-1.4l1-3.69a3.2 3.2 0 00-1.84-3.87l-2.23-1.05a1.75 1.75 0 01-1.07-1.59v-.4h14.2v.4zM1.2 0C.55 0 0 .54 0 1.2v12.14c0 1.22.7 2.11 1.8 2.62l2.2 1c.75.36 1.16 1.44.92 2.24l-1.07 3.56a4.13 4.13 0 003.97 5.32h.26a4.17 4.17 0 004.05-3.25v-.02c.15-.68.12-1.4-.08-2.06l-1.07-3.55c-.24-.8.06-1.82.82-2.17l2.2-1.01c1.1-.5 1.9-1.47 1.9-2.68V1.2c0-.66-.54-1.2-1.2-1.2H1.2zm6.75 25.11a.92.92 0 100-1.84.92.92 0 000 1.84z"
                                                      fill-rule="nonzero" fill="#525B61"></path>
                                                <path d="M15.05 13.2c0 .67-.42 1.3-1.07 1.58l-2.07 1.05a3.2 3.2 0 00-1.85 3.87l.85 3.7c.14.44.16.92.06 1.37v.02a2.93 2.93 0 01-2.88 2.2H7.8a2.93 2.93 0 01-2.88-2.2c-.1-.46-.08-.94.06-1.4l1-3.69a3.2 3.2 0 00-1.84-3.87l-2.23-1.05a1.75 1.75 0 01-1.07-1.59v-.4h14.2v.4z"
                                                      fill="#FFF"></path>
                                                <path d="M.95 11.95h14v-11h-14z" fill="#EAEBEF"></path>
                                                <rect rx=".5" fill="#525B61" y="11.95" height="1" width="15.6"></rect>
                                            </g>
                                            <path transform="rotate(-36 23.82 -17.86)"
                                                  d="M12.6 6.77a.63.63 0 01-.38.38c-.52.17-.95.48-1.27.91l-3.43 4.66-.62-.45-.27-.18 3.44-4.66c.31-.43.48-.93.49-1.46 0-.2.1-.37.25-.49l1.95-1.46.65.47-.8 2.28zm-3.8 8.21l-.68.93-1.2.43c-.83.29-1.46.97-1.7 1.81l-.53 1.98a4.5 4.5 0 01-.71 1.48l-2.03 2.78a2.84 2.84 0 01-3.98.63 2.82 2.82 0 01-.63-3.97l2.02-2.78c.33-.45.73-.83 1.2-1.13L2.26 16a2.66 2.66 0 001.2-2.16l.04-1.28.67-.93 4.61 3.34zm4.15-12a.6.6 0 00-.72.01l-2.18 1.65c-.44.34-.7.86-.7 1.41 0 .25-.09.49-.23.69l-3.4 4.68-1.02-.74a1 1 0 00-1.4.23l-.82 1.12a1 1 0 00-.19.56l-.03 1.3c-.01.46-.25.87-.62 1.12L-.03 16.1c-.57.37-1.07.84-1.47 1.4l-1.96 2.7a3.94 3.94 0 00.88 5.54 3.95 3.95 0 002.96.71 3.96 3.96 0 002.6-1.59l1.97-2.7c.4-.55.7-1.17.87-1.82l.52-1.92c.12-.44.45-.79.87-.94l1.24-.43c.2-.07.36-.2.48-.36l.81-1.12a1 1 0 00-.22-1.4l-1.02-.73 3.4-4.68c.15-.2.35-.35.59-.43.53-.18.94-.58 1.12-1.11l.9-2.58a.6.6 0 00-.21-.69l-1.35-.97z"
                                                  fill-rule="nonzero" fill="#525B61"></path>
                                            <path transform="rotate(-36 24.06 -25.79)"
                                                  d="M7.99 5.16a.62.62 0 01-.4.38c-.5.17-.94.48-1.26.91L2.9 11.11l-.62-.45-.27-.18 3.44-4.66c.31-.43.48-.93.49-1.46 0-.2.1-.37.25-.49l1.95-1.46.65.47L8 5.16z"
                                                  fill="#FFF"></path>
                                            <path transform="rotate(-36 24.2 -13.34)"
                                                  d="M11.55 15.59l-.67.93-1.21.42c-.83.3-1.46.97-1.69 1.82l-.54 1.98a4.52 4.52 0 01-.7 1.47L4.7 25a2.84 2.84 0 01-3.98.63 2.83 2.83 0 01-.63-3.97l2.02-2.79c.33-.44.73-.82 1.19-1.13l1.72-1.12a2.66 2.66 0 001.2-2.16l.03-1.28.68-.93 4.61 3.34z"
                                                  fill="#FFF"></path>
                                        </g>
                                    </svg>
                                </div>
                                <div class="sub-info-overview-text">
                                    <c:choose>
                                        <c:when test="${boardModel.workingArea eq 'remodeling'}">리모델링</c:when>
                                        <c:when test="${boardModel.workingArea eq 'homestyling'}">홈스타일링</c:when>
                                        <c:when test="${boardModel.workingArea eq 'partial'}">부분공사</c:when>
                                        <c:when test="${boardModel.workingArea eq 'construct'}">건축</c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty boardModel.familyType}">
                            <div class="sub-info-overview-type">
                                <div class="sub-info-overview-icon">
                                    <svg class="icon" aria-label="가족형태" width="39" height="38" viewBox="0 0 39 38"
                                         preserveAspectRatio="xMidYMid meet">
                                        <g fill="none" fill-rule="evenodd">
                                            <path d="M1 0h38v38H1z"></path>
                                            <path fill="#EAEBEF"
                                                  d="M1.409 30.382l.489-3.553 1.063-2.294 1.154-1.749.898-1.073 1.136-.704.747-.659 1.015.412 1.562.951h2.982l1.422-.951.762-.412 1.12 1.064 1.563 1.372 1.201 1.507.814 1.974.595 2.432.257 2.207v-.524z"></path>
                                            <path fill="#525B61" fill-rule="nonzero" stroke="#525B61" stroke-width=".1"
                                                  d="M15.322 20.596a7.108 7.108 0 002.577-5.477c0-3.926-3.194-7.119-7.12-7.119-3.925 0-7.119 3.193-7.119 7.119 0 2.2 1.004 4.17 2.577 5.476C3.034 22.301 1 25.818 1 29.75a.468.468 0 10.937 0c0-3.761 2.032-7.092 5.18-8.537a7.072 7.072 0 003.662 1.026 7.066 7.066 0 003.656-1.022c3.153 1.446 5.187 4.762 5.187 8.533a.468.468 0 10.937 0c0-3.942-2.032-7.448-5.237-9.154zm-4.543.705a6.188 6.188 0 01-6.181-6.182 6.188 6.188 0 016.181-6.182 6.189 6.189 0 016.183 6.182 6.19 6.19 0 01-6.183 6.182z"></path>
                                            <path fill="#FFF"
                                                  d="M10.78 21.301a6.188 6.188 0 01-6.182-6.182 6.188 6.188 0 016.181-6.182 6.189 6.189 0 016.183 6.182 6.19 6.19 0 01-6.183 6.182z"></path>
                                            <path fill="#EAEBEF"
                                                  d="M19.2 30.382l.489-3.553 1.062-2.294 1.155-1.749.898-1.073 1.136-.704.746-.659 1.016.412 1.562.951h2.982l1.422-.951.762-.412 1.12 1.064 1.563 1.372 1.201 1.507.813 1.974.596 2.432.257 2.207v-.524z"></path>
                                            <path fill="#525B61" fill-rule="nonzero" stroke="#525B61" stroke-width=".1"
                                                  d="M33.522 20.596a7.108 7.108 0 002.577-5.477c0-3.926-3.194-7.119-7.12-7.119-3.925 0-7.119 3.193-7.119 7.119 0 2.2 1.004 4.17 2.576 5.476-3.202 1.706-5.236 5.223-5.236 9.155a.468.468 0 10.937 0c0-3.761 2.032-7.092 5.18-8.537a7.069 7.069 0 003.662 1.026 7.071 7.071 0 003.656-1.022c3.153 1.446 5.187 4.762 5.187 8.533a.468.468 0 10.937 0c0-3.942-2.032-7.448-5.237-9.154zm-4.543.705a6.188 6.188 0 01-6.181-6.182 6.188 6.188 0 016.181-6.182 6.188 6.188 0 016.182 6.182 6.19 6.19 0 01-6.182 6.182z"></path>
                                            <path fill="#FFF"
                                                  d="M28.98 21.301a6.188 6.188 0 01-6.182-6.182 6.188 6.188 0 016.181-6.182 6.188 6.188 0 016.182 6.182 6.19 6.19 0 01-6.182 6.182z"></path>
                                            <path fill="#525B61" fill-rule="nonzero"
                                                  d="M10.731 18.495c1.136 0 2.213-.498 2.766-1.329.204-.277.116-.665-.204-.859a.657.657 0 00-.902.194c-.32.471-.961.748-1.66.748-.698 0-1.339-.277-1.659-.748a.713.713 0 00-.902-.194c-.292.194-.379.582-.204.859.553.83 1.6 1.33 2.765 1.33zm18.276 0c1.136 0 2.213-.498 2.766-1.329.204-.277.116-.665-.204-.859a.657.657 0 00-.902.194c-.32.471-.96.748-1.66.748-.698 0-1.339-.277-1.659-.748a.713.713 0 00-.902-.194c-.291.194-.379.582-.204.859.553.83 1.601 1.33 2.765 1.33z"></path>
                                        </g>
                                    </svg>
                                </div>
                                <div class="sub-info-overview-text">
                                    <c:choose>
                                        <c:when test="${boardModel.familyType eq 'singlelife'}">싱글라이프</c:when>
                                        <c:when test="${boardModel.familyType eq 'honeymoon'}">신혼 부부</c:when>
                                        <c:when test="${boardModel.familyType eq 'withbaby'}">아기가 있는 집</c:when>
                                        <c:when test="${boardModel.familyType eq 'withchild'}">취학 자녀가 있는 집</c:when>
                                        <c:when test="${boardModel.familyType eq 'withparent'}">부모님과 함께 사는 집</c:when>
                                        <c:when test="${boardModel.familyType eq 'etc'}">기타</c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                    </div>
                    <div class="sub-info-detail">
                        <div class="sub-info-detail-item">
                            <div class="sub-info-detail-text">주거형태</div>
                            <div class="sub-info-detail-value">
                                <c:choose>
                                    <c:when test="${boardModel.type eq 'oneroom'}">원룸&오피스텔</c:when>
                                    <c:when test="${boardModel.type eq 'apartment'}">아파트</c:when>
                                    <c:when test="${boardModel.type eq 'villa'}">빌라</c:when>
                                    <c:when test="${boardModel.type eq 'house'}">단독주택</c:when>
                                    <c:when test="${boardModel.type eq 'office'}">사무공간</c:when>
                                    <c:when test="${boardModel.type eq 'commercial'}">상업공간</c:when>
                                    <c:when test="${boardModel.type eq 'etc'}">기타</c:when>
                                </c:choose>
                            </div>
                        </div>
                        <div class="sub-info-detail-item">
                            <div class="sub-info-detail-text">가족형태</div>
                            <div class="sub-info-detail-value">
                                <c:choose>
                                    <c:when test="${boardModel.familyType eq 'singlelife'}">싱글라이프</c:when>
                                    <c:when test="${boardModel.familyType eq 'honeymoon'}">신혼 부부</c:when>
                                    <c:when test="${boardModel.familyType eq 'withbaby'}">아기가 있는 집</c:when>
                                    <c:when test="${boardModel.familyType eq 'withchild'}">취학 자녀가 있는 집</c:when>
                                    <c:when test="${boardModel.familyType eq 'withparent'}">부모님과 함께 사는 집</c:when>
                                    <c:when test="${boardModel.familyType eq 'etc'}">기타</c:when>
                                </c:choose>
                            </div>
                        </div>
                        <div class="sub-info-detail-item">
                            <div class="sub-info-detail-text">작업분야</div>
                            <div class="sub-info-detail-value">
                                <c:choose>
                                    <c:when test="${boardModel.workingArea eq 'remodeling'}">리모델링</c:when>
                                    <c:when test="${boardModel.workingArea eq 'homestyling'}">홈스타일링</c:when>
                                    <c:when test="${boardModel.workingArea eq 'partial'}">부분공사</c:when>
                                    <c:when test="${boardModel.workingArea eq 'construct'}">건축</c:when>
                                </c:choose>
                            </div>
                        </div>
                        <div class="sub-info-detail-item">
                            <div class="sub-info-detail-text">작업자</div>
                            <div class="sub-info-detail-value">
                                <c:choose>
                                    <c:when test="${boardModel.worker eq 'self'}">셀프&DIY</c:when>
                                    <c:when test="${boardModel.worker eq 'halfself'}">반셀프</c:when>
                                    <c:when test="${boardModel.worker eq 'expert'}">전문가</c:when>
                                </c:choose>
                            </div>
                        </div>
                        <c:if test="${not empty boardModel.sqft}">
                            <div class="sub-info-detail-item">
                                <div class="sub-info-detail-text">평수</div>
                                <div class="sub-info-detail-value">
                                    <c:choose>
                                        <c:when test="${boardModel.sqft eq 'sqft9'}">0~9평</c:when>
                                        <c:when test="${boardModel.sqft eq 'sqft10'}">10평대</c:when>
                                        <c:when test="${boardModel.sqft eq 'sqft20'}">20평대</c:when>
                                        <c:when test="${boardModel.sqft eq 'sqft30'}">30평대</c:when>
                                        <c:when test="${boardModel.sqft eq 'sqft40'}">40평대</c:when>
                                        <c:when test="${boardModel.sqft eq 'sqft50'}">50평대</c:when>
                                        <c:when test="${boardModel.sqft eq 'sqft60'}">60평대 이상</c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty boardModel.roomNum}">
                            <div class="sub-info-detail-item">
                                <div class="sub-info-detail-text">방 개수</div>
                                <div class="sub-info-detail-value">
                                    <c:choose>
                                        <c:when test="${boardModel.roomNum eq 'rn1'}">1개</c:when>
                                        <c:when test="${boardModel.roomNum eq 'rn1.5'}">1.5개</c:when>
                                        <c:when test="${boardModel.roomNum eq 'rn2'}">2개</c:when>
                                        <c:when test="${boardModel.roomNum eq 'rn3'}">3개</c:when>
                                        <c:when test="${boardModel.roomNum eq 'rn4'}">4개</c:when>
                                        <c:when test="${boardModel.roomNum eq 'rn5'}">5개이상</c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty boardModel.direction}">
                            <div class="sub-info-detail-item">
                                <div class="sub-info-detail-text">방향</div>
                                <div class="sub-info-detail-value">
                                    <c:choose>
                                        <c:when test="${boardModel.direction eq 'south'}">남향</c:when>
                                        <c:when test="${boardModel.direction eq 'west'}">서향</c:when>
                                        <c:when test="${boardModel.direction eq 'east'}">동향</c:when>
                                        <c:when test="${boardModel.direction eq 'north'}">북향</c:when>
                                        <c:when test="${boardModel.direction eq 'south-west'}">남서향</c:when>
                                        <c:when test="${boardModel.direction eq 'south-east'}">남동향</c:when>
                                        <c:when test="${boardModel.direction eq 'north-west'}">북서향</c:when>
                                        <c:when test="${boardModel.direction eq 'north-east'}">북동향</c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty boardModel.year}">
                            <div class="sub-info-detail-item">
                                <div class="sub-info-detail-text">준공연차</div>
                                <div class="sub-info-detail-value">
                                    <c:choose>
                                        <c:when test="${boardModel.year eq 'year1980'}">1980~1990</c:when>
                                        <c:when test="${boardModel.year eq 'year1990'}">1990~2000</c:when>
                                        <c:when test="${boardModel.year eq 'year2000'}">2000~2010</c:when>
                                        <c:when test="${boardModel.year eq 'year2010'}">2010~2020</c:when>
                                        <c:when test="${boardModel.year eq 'year2020'}">2020~</c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty boardModel.location}">
                            <div class="sub-info-detail-item">
                                <div class="sub-info-detail-text">지역</div>
                                <div class="sub-info-detail-value">
                                    <c:choose>
                                        <c:when test="${boardModel.location eq 'Seoul'}">서울특별시</c:when>
                                        <c:when test="${boardModel.location eq 'Busan'}">부산광역시</c:when>
                                        <c:when test="${boardModel.location eq 'Daegu'}">대구광역시</c:when>
                                        <c:when test="${boardModel.location eq 'Incheon'}">인천광역시</c:when>
                                        <c:when test="${boardModel.location eq 'Gwangju'}">광주광역시</c:when>
                                        <c:when test="${boardModel.location eq 'Daejeon'}">대전광역시</c:when>
                                        <c:when test="${boardModel.location eq 'Ulsan'}">울산광역시</c:when>
                                        <c:when test="${boardModel.location eq 'Gangwon'}">강원도</c:when>
                                        <c:when test="${boardModel.location eq 'Gyeonggi'}">경기도</c:when>
                                        <c:when test="${boardModel.location eq 'Gyeongsang'}">경상도</c:when>
                                        <c:when test="${boardModel.location eq 'Jeolla'}">전라도</c:when>
                                        <c:when test="${boardModel.location eq 'Chungcheong'}">충청도</c:when>
                                        <c:when test="${boardModel.location eq 'Sejong'}">세종특별자치시</c:when>
                                        <c:when test="${boardModel.location eq 'Jeju'}">제주특별자치도</c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>

            <div class="contents">
                ${boardModel.content}
            </div>

            <div class="bottom-count">
                <ul>
                    <li>좋아요
                        <span class="bottom-like-count">
                            ${favorMap.favorCnt}
                        </span>
                    </li>
                    <li>댓글
                        <span class="bottom-comments-count">
                            ${commentsMap.commentsCnt}
                        </span>
                    </li>
                    <li>조회 ${boardModel.vcount}</li>
                </ul>
                <c:if test="${boardModel.brdMnum eq boardModel.usrMnum}">
                    <button class="bottom-count-btn del-btn">삭제</button>
                    <button class="bottom-count-btn upd-btn">수정</button>
                </c:if>
            </div>

            <div class="bottom-info">
                <div class="bottom-info-profileImg">
                	<a href="/myPage/user/${boardModel.brdMnum }">
                    <img src="../resources/uploadimg/${boardModel.mbrImg}">
                    </a>
                </div>
                <div class="bottom-info-nameTime">
                    <div>${boardModel.mbrNickname}</div>
                    <div>${boardModel.mbrIntroduce}</div>
                </div>
                <c:if test="${boardModel.brdMnum ne boardModel.usrMnum}">
                    <div class="bottom-info-follow">
                        <button class="btn-follow bottom <c:if test="${followYn == 'Y'}">on</c:if>"></button>
                    </div>
                </c:if>
            </div>
        </div>

        <div class="comments">
            <!-- 게시글 내용 및 댓글 등록 폼 -->
            <div id="post">
                <form id="commentForm">
                    <c:choose>
                        <c:when test="${boardModel.usrMnum == 0}"><img src="../../../../resources/uploadimg/default-profile.png"></c:when>
                        <c:when test="${boardModel.usrMnum != 0}"><img src="../../../../resources/uploadimg/${currMbr.img}"></c:when>
                    </c:choose>
                    <textarea type="text" id="commentInput" rows="1" maxlength="80"></textarea>
                    <button type="submit">댓글 등록</button>
                </form>
            </div>

            <!-- 댓글 목록 -->
            <div id="comments">
                <!-- 댓글 수정 폼 -->
                <h2>댓글 목록</h2>
                <ul id="getCommentsList">
                    <!-- 댓글 목록 출력 -->
                </ul>
            </div>
        </div>

        <div class="side">
            <section class="sticky-area">
                <button class="sticky-btn favor-btn <c:if test="${favorMap.favorYn == 'Y'}">on</c:if>"></button>
                <span class="sticky-counter favor-cnt">${favorMap.favorCnt}</span>

                <button class="sticky-btn comments-btn"></button>
                <span class="sticky-counter comments-cnt">${commentsMap.commentsCnt}</span>

                <button class="sticky-btn top-btn"></button>
            </section>
        </div>
    </div>
</div>
</body>
<script src="../../../resources/js/boardSelectOne.js"></script>
</html>