<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../layout/header.jsp" %>
<div class="container">
   <div>
      <h2>Image</h2>
   </div>
   <div class="panel panel-default">
      <div class="panel-heading">프로필 등록</div>
         <div class="panel-body">
            <form action="${contextPath}/member/imageUpdate" method="post" enctype="multipart/form-data">
               <input type="hidden" name="id" value="${mvo.id}">
               <table class="table table-bordered" style="text-align: center; border: 1px solid; #dddddd;">
                  <tr>
                     <td style="width: 110px; vertical-align: middle;">아이디</td>
                     <td>${mvo.id}</td>
                  </tr>
                  <tr>
                     <td style="width: 110px; vertical-align: middle;">사진 업로드</td>
                     <td colspan="2">
                        <span class="btn btn-default">이미지를 업로드하세요.<br>
                           <input type="file" name="attachFile"/>
                        </span>
                     </td>
                  </tr>
               </table>
               <button class="btn btn-primary btn-sm pull-right">등록</button>
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
</script>