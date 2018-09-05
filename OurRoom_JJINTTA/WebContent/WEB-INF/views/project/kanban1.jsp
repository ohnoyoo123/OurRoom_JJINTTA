<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.9.0.js"></script>
<script src="https://code.jquery.com/ui/1.9.0/jquery-ui.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react-dom.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.min.js"></script>

<style type="text/css">

  #innerFrame {
    display: inline-block;
    width: 95%;
    position: absolute;
    margin: 10px;
  }

  #ideas, #toDo, #doing, #done, #review{
    float: left;
    background-color: #0099ff;
    width: 18%;
    display: inline-block;
    margin-left: 10px;
    margin-right: 10px;
    text-align: center;
    border-radius: 10px;
  }

  .issue{
    background-color: #ff9999;
    margin: 5px;
    border-radius: 10px;
    height: 80px;
  }

  .addIssue{
    background-color: #ffff66;
    margin: 5px;
    border-radius: 10px;
    height: 40px;
  }
</style>

<script>
  $(function(){
    $(".datepicker").datepicker();
  });
</script>

</head>

<body>
  <jsp:include page="../mainFrame.jsp" />
  <div id="innerFrame">
    <div id="projectInfo"></div>
    <div id="taskInfo"></div>
    <div id="ideas">ideas</div>
    <div id="toDo">toDo</div>
    <div id="doing">doing</div>
    <div id="done">done</div>
    <div id="review">review</div>
  </div>

  <!-- 이슈 상세보기 모달 -->
  <div class="modal fade" id="issueModal">
  </div>


  <!-- 이슈 추가 모달 -->
	<div class="modal fade" id="addIssueModal">
	</div>

</body>


<script type="text/babel">
const ProjectInfo = React.createClass({

  render : () => {
    return(
      <div id="projectInfo">
        <table className="table table-bordered">
        <tbody>
          <tr>
            <th>프로젝트 번호</th>
            <th>프로젝트 이름</th>
            <th>프로젝트 시작</th>
            <th>프로젝트 종료</th>
          </tr>
          <tr>
            <td>${project.pNum}</td>
            <td id="viewGantt">${project.pName}</td>
            <td><fmt:formatDate value="${project.pStartDate}" type="date" pattern="yyyy-MM-dd"/></td>
            <td><fmt:formatDate value="${project.pEndDate}" type="date" pattern="yyyy-MM-dd"/></td>
          </tr>
          </tbody>
        </table>
      </div>
    )
  }
})


const TaskInfo = React.createClass({
  render : () => {
    return(
      <table className="table table-bordered">
      <tbody>
        <tr>
          <th>태스크 번호</th>
          <th>태스크 이름</th>
          <th>태스크 시작</th>
          <th>태스크 종료</th>
          <th>태스크 공지</th>
        </tr>
        <tr>
          <td>${task[0].tNum}</td>
          <td>${task[0].tName}</td>
          <td><fmt:formatDate value="${task[0].tStartDate}" type="date" pattern="yyyy-MM-dd"/></td>
          <td><fmt:formatDate value="${task[0].tEndDate}" type="date" pattern="yyyy-MM-dd"/></td>
          <td id="tNoti">${task[0].tNotiName}</td>
        </tr>
        </tbody>
      </table>

    )
  }
})


const Ideas = React.createClass({

    render : () => {
      return(
        <div id="ideas">
          <h3 className="iStep" iStep="0">IDEAS</h3>
            <c:forEach items="${issueList}" var="issue">
              <c:if test="${issue.iStep == 0}">
                <div className="issue" iNum="${issue.iNum}" data-toggle="modal" data-target="#issueModal">
                  ${issue.iName}
                </div>
              </c:if>
            </c:forEach>
          <div className="addIssue" data-toggle="modal" data-target="#addIssueModal">
          [+]
          </div>
        </div>
      )
    }
  })


const Todo = React.createClass({

    render : () => {
      return(
        <div id="toDo">
          <h3 className="iStep" iStep="1">To do</h3>
            <c:forEach items="${issueList}" var="issue">
              <c:if test="${issue.iStep == 1}">
                <div className="issue" iNum="${issue.iNum}" data-toggle="modal" data-target="#issueModal">
                  ${issue.iName}
                </div>
              </c:if>
          </c:forEach>
          <div className="addIssue" data-toggle="modal" data-target="#addIssueModal">
          [+]
          </div>
        </div>
      )
    }
  })


const Doing = React.createClass({

    render : () => {
      return(
        <div id="doing">
          <h3 className="iStep" iStep="2">DOING</h3>
            <c:forEach items="${issueList}" var="issue">
              <c:if test="${issue.iStep == 2}">
                <div className="issue" iNum="${issue.iNum}" data-toggle="modal" data-target="#issueModal">
                  ${issue.iName}
                </div>
              </c:if>
            </c:forEach>
          <div className="addIssue" data-toggle="modal" data-target="#addIssueModal">
          [+]
          </div>
        </div>
      )
    }
  })

const Done = React.createClass({

    render : () => {
      return(
        <div id="done">
            <h3 className="iStep" iStep="3">DONE</h3>
            <c:forEach items="${issueList}" var="issue">
              <c:if test="${issue.iStep == 3}">
                <div className="issue" iNum="${issue.iNum}" data-toggle="modal" data-target="#issueModal">
                  ${issue.iName}
                </div>
              </c:if>
            </c:forEach>
          <div className="addIssue" data-toggle="modal" data-target="#addIssueModal">
          [+]
          </div>
        </div>
      )
    }
  })


const Review = React.createClass({

    render : () => {
      return(
        <div id="review">
          <h3 className="iStep" iStep="4">REVIEW</h3>
            <c:forEach items="${issueList}" var="issue">
              <c:if test="${issue.iStep == 4}">
                <div className="issue" iNum="${issue.iNum}" data-toggle="modal" data-target="#issueModal">
                  ${issue.iName}
                </div>
              </c:if>
            </c:forEach>
          <div className="addIssue" data-toggle="modal" data-target="#addIssueModal">
          [+]
          </div>
        </div>
      )
    }
  })


  const IssueModal = React.createClass({

    render : () => {
      return(
        <div className="modal fade" id="issueModal">
          <div className="modal-dialog">
            <div className="modal-content">

              <div className="modal-header">
              </div>

              <div className="modal-body">
                팀원 할당 : <br/>
              </div>
              할당된 팀원 : <br/>
              <div className="modal-body" id="assignedMember">
              </div>
              <div className="modal-body" id="selectedMId">
              </div>
              <div className="modal-body">
              </div>
              <div className="modal-footer">
              </div>
            </div>
          </div>
        </div>

      )
    }
  })


const InnerFrame = React.createClass({
	render : () => {
        return (
          <fragment>
            <ProjectInfo/>
            <TaskInfo/>
            <Ideas/>
            <Todo/>
            <Doing/>
            <Done/>
            <Review/>
          </fragment>

		)
	}
})


ReactDOM.render(<InnerFrame/>, document.getElementById('innerFrame'))

</script>

</html>
