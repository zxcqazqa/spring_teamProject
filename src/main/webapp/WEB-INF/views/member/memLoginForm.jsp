<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../layout/header.jsp" %>
<div class="container">
   <div>
      <h2>Login</h2>
   </div>
   <div class="panel panel-default">
       <div class="panel-heading">로그인</div>
   <div class="panel-body">
      <form action="${contextPath}/member/login" method="post">
      <table class="table table-bordered" style="text-align: center; border: 1px solid; #dddddd;">
         <tr>
            <td style="width: 110px; vertical-align: middle;">아이디</td>
            <td><input id="id" name="id" class="form-control" type="text" maxlength="20" placeholder="아이디를 입력하세요."/></td>
         </tr>
         <tr>
            <td style="width: 110px; vertical-align: middle;">비밀번호</td>
            <td colspan="2"><input id="pwd" name="pwd" class="form-control" type="password" maxlength="20" placeholder="비밀번호를 입력하세요."/></td>
         </tr>
         <tr>
            <td colspan="2" style="text-align: center;">
               <input type="submit" class="btn btn-primary btn-sm pull-right" value="로그인" /> 
            </td>
         </tr>
      </table>
      </form>
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
</script>