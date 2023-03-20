<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../layout/header.jsp" %>
<div class="container">
   <div class="container topMenu mt-3 mb-3 ">
      <div>
         <h2>Sign up</h2>
      </div>
       <div class="panel panel-default">
    <div class="panel-heading">회원가입</div>
    <div class="panel-body">
     <form name="frm" action="${contextPath}/member/register" method="post">
      <input type="hidden" id="pwd" name="pwd" value=""/>
      <table class="table table-bordered" style="text-align: center; border: 1px solid; #dddddd;">
       <tr>
        <td style="width: 110px; vertical-align: middle;">아이디</td>
        <td><input id="id" name="id" class="form-control" type="text" maxlength="20" placeholder="아이디를 입력하세요."/></td>
        <td style="width: 110px;"><button type="button" class="btn btn-primary btn-sm" onclick="registerCheck()">중복확인</button></td>
       </tr>
       <tr>
        <td style="width: 110px; vertical-align: middle;">비밀번호</td>
        <td colspan="2"><input id="password1" name="password1" onkeyup="passwordCheck()" class="form-control" type="password" maxlength="20" placeholder="비밀번호를 입력하세요."/></td>
       </tr>
       <tr>
        <td style="width: 110px; vertical-align: middle;">비밀번호 확인</td>
        <td colspan="2"><input id="password2" name="password2" onkeyup="passwordCheck()" class="form-control" type="password" maxlength="20" placeholder="비밀번호를 확인하세요."/></td>
       </tr>
       <tr>
        <td style="width: 110px; vertical-align: middle;">이름</td>
        <td colspan="2"><input id="name" name="name"  class="form-control" type="text" maxlength="20" placeholder="이름을 입력하세요."/></td>
       </tr>
       <tr>
        <td style="width: 110px; vertical-align: middle;">나이</td>
        <td colspan="2"><input id="age" name="age"  class="form-control" type="number" maxlength="20" placeholder="나이를 입력하세요."/></td>
       </tr>
       <tr>
        <td style="width: 110px; vertical-align: middle;">성별</td>
        <td colspan="2">
         <div class="form-group" style="text-align: center; margin: 0 auto;">
          <div class="btn-group" data-toggle="buttons">
           <label class="btn btn-primary active">
            <input type="radio" id="gender" name="gender" autocomplete="off" value="남자" checked /> 남자
           </label>
           <label class="btn btn-primary">
            <input type="radio" id="gender" name="gender" autocomplete="off" value="여자" /> 여자
           </label>
          </div>
         </div>
        </td>
       </tr>
       <tr>
        <td style="width: 110px; vertical-align: middle;">이메일</td>
        <td colspan="2"><input id="email" name="email" class="form-control" type="text" maxlength="20" placeholder="이메일을 입력하세요."/></td>
       </tr>
       <tr>
        <td colspan="3" style="text-align: left;">
         <span id="passMessage" style="color: red"></span>
            <div style='width:80px;float: right;'>
               <input type="button" class="btn btn-primary" value="등록" onclick="goInsert()"/>
            </div>
        </td>
       </tr>
      </table>
     </form>
    </div>
    <!-- 다이얼로그창(모달) -->
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

    <!-- Modal content-->
    <div id="checkType" class="modal-content panel-info">
      <div class="modal-header panel-heading">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">메시지 확인</h4>
      </div>
      <div class="modal-body">
        <p id="checkMessage"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
        </div>
   </div>
   <!-- 실패 메세지 출력(modal) -->
   <div id="myMessage" class="modal fade" role="dialog">
        <div class="modal-dialog">

    <!-- Modal content-->
    <div id="messageType" class="modal-content panel-info">
      <div class="modal-header panel-heading">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">${msgType}</h4>
      </div>
      <div class="modal-body">
        <p>${msg}</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
        </div>
   </div>
   
    <div class="panel-footer"></div>
  </div>
</div>
<%@include file="../layout/footer.jsp" %>

<script type="text/javascript">
   $(document).ready(function(){
      if(${!empty msgType}){
            $("#messageType").attr("class", "modal-content panel-warning");    
           $("#myMessage").modal("show");
        }
     });
     
     function registerCheck() {
      var id=$("#id").val();
      $.ajax({
         url : "${contextPath}/member/registerCheck",
         type : "get",
         data : {"id" : id},
         success : function(result) {
            // 중복유무 출력(result=1 : 사용할수있는 아이디, 0 : 사용할수없는 아이디)
            if(result==1){
                  $("#checkMessage").html("사용할 수 있는 아이디입니다.");
                  $("#checkType").attr("class", "modal-content panel-success");
             } else {
                  $("#checkMessage").html("사용할 수 없는 아이디입니다."); 
                  $("#checkType").attr("class", "modal-content panel-warning");
             }
             $("#myModal").modal("show");
         },
         error : function() { alert("error")}
      });
   }
     
     function passwordCheck(){
       var password1=$("#password1").val();
       var password2=$("#password2").val();
       if(password1 != password2){
          $("#passMessage").html("비밀번호가 서로 일치하지 않습니다.");
       }else{
          $("#passMessage").html("");
          $("#pwd").val(password1);
       }      
    }
     
     function goInsert() {
      var age=$("#age").val();
      if(age==null || age=="" || age==0){
         alert("나이를 입력하세요");
         return false;
      }
      document.frm.submit();   // 전송
   }
</script>