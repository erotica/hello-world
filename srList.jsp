<!--
	 파 일 명  : srList.jsp
	 작성일자  : 2016-04-06
	 작 성 자  : mailbest
	 내    용  : SR요청 조회리스트
-->
<%@ page contentType="text/html;charset=ksc5601" errorPage="/common/error.jsp" %>
<%@ page import="com.wms.fw.util.DateUtil"%>
<%@ page import="com.wms.fw.servlet.HttpUtility" %>
<%@ page import="com.wms.fw.Utility"%>
<%@ page import="com.wms.fw.servlet.Box" %>
<%@ page import="com.wms.common.beans.dto.DataSet"%>
<%@ page import="com.wms.fw.db.DataBaseUtil"%>

<jsp:useBean id="user" class="com.wms.beans.dto.UserInfo"	scope="session" />
<%
	request.setCharacterEncoding("ksc5601");
	Box box = HttpUtility.getBox(request);
	
	String[] parameters=new String[20];
	String currentDate = DateUtil.getTodayString("-");
	
	request.setAttribute("fileName", "ResCheckOut.xml");
	request.setAttribute("idx", "SCM_001");
	request.setAttribute("parameters", parameters);
	request.setAttribute("setString", "Y");//parameter을 컬럼명으로 지정할때 사용

	parameters[0]="S_FR_DT";
	
	if (box.get("Fr_yymm").equals("")){
		parameters[1]=DateUtil.transDate(DateUtil.addMonth(currentDate,-1));
	} else {
		parameters[1]=box.get("Fr_yymm");
	}

		parameters[2]="S_TO_DT"; 
		
	if (box.get("To_yymm").equals("")){
		parameters[3]=DateUtil.getTodayString("-"); 
	} else {
		parameters[3]=box.get("To_yymm");
	}
	
	parameters[4]= "S_SR_SYSTEM";
	parameters[5]=box.get("S_SR_SYSTEM");
	
	parameters[6]= "S_SR_TYPE";
	parameters[7]=box.get("S_SR_TYPE");
	
	parameters[8]= "S_SR_TITLE";
	parameters[9]=box.get("S_SR_TITLE");
	
	parameters[10]= "S_SR_EMPID";
	parameters[11]=box.get("S_SR_EMPID");
	
	parameters[12]= "S_SR_REV_EMPID";
	parameters[13]=box.get("S_SR_REV_EMPID");
	
	parameters[14]= "S_SR_DOC_TYPE";
	parameters[15]=box.get("S_SR_DOC_TYPE");
	
	parameters[16]= "S_SR_CONF_TYPE";
	parameters[17]=box.get("S_SR_CONF_TYPE");
	
 %>
<jsp:include page="/common/comDataSet.jsp" flush="true" />	
	<%
	DataSet set=(DataSet)request.getAttribute("set");	
	int idx=0;
	if (set!=null)	idx=set.getLength("WORKSPACE_ID");
	%>

<% int size = 0; %>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7, IE=EmulateIE9"/>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="Content-Type"	content="text/html; charset=ks_c_5601-1987">
<LINK rel="stylesheet" type="text/css"	href="../css/skin04_viewstyle.css">
<script Language="JavaScript" src="/common/link/calendar.js"></script>
<script Language="JavaScript" src="/common/link/tagCalendar.js"></script>
<script Language="JavaScript" src="/common/link/common.js"></script>
<script Language="JavaScript" src="/common/link/combo.js"></script>
<script Language='javascript'>
	$(function() {
              $("table tr:nth-child(even)").addClass("striped");
	});
</script><script language='javascript'>

function initTop(){
	var frm = document.forms[0];
	frm.target='top';
	frm.action='/CMS/top.jsp?S_SR_NO=<%=parameters[1]%>';
	frm.submit();
}
function init(){
	var frm = document.forms[0];
	//initTop();
	//combobox 초기화
	fn_combo('S_SR_SYSTEM',new Array(frm.Fr_yymm.value,frm.To_yymm.value));	//대상시스템
	fn_combo('S_SR_TYPE',new Array(frm.Fr_yymm.value,frm.To_yymm.value));	//SR유형
	fn_combo('S_SR_DOC_TYPE',new Array(frm.Fr_yymm.value,frm.To_yymm.value));	//문서단계
	fn_combo('S_SR_CONF_TYPE',new Array(frm.Fr_yymm.value,frm.To_yymm.value));	//결재상태
	fn_combo('S_SR_EMPID',new Array(frm.Fr_yymm.value,frm.To_yymm.value));	//요청자
	fn_combo('S_SR_REV_EMPID',new Array(frm.Fr_yymm.value,frm.To_yymm.value));	//담당자/접수자
}
	
function search(){
		var frm = document.form1;
		divSearch(); //지연창 보이기
		frm.submit();	
	}
function create(){
		var frm = document.form1;
		frm.action='/CMS/srCreate.jsp';
		frm.target='_self';
		frm.submit();	
	}

function save(){
	 var frm=document.forms[0];
	      divSearch("처리 중 입니다."); //검색 지연창 보이기
	      alert();
	   frm._SCREEN.value='/CMS/srList.jsp';
	   frm.action='asrMngSave.do';
	   frm.target='_self';
	   frm.submit(); 
 } 
function Excel(){
	 var frm=document.forms[0];
	      divSearch("엑셀다운로드 중 입니다."); //검색 지연창 보이기 
	   frm.Action='/IpMng/IpMngExcel.jsp';
	   frm.submit(); 
 } 
function viewSource(SR_NO){
	 var frm=document.forms[0];
	   divSearch(); //검색 지연창 보이기
	   frm.action='/CMS/srView.jsp?S_SR_NO='+SR_NO;
	   frm.target='_self';
	   frm.submit(); 
 } 
</script>
</head>
<title>보안조치관리</title>
</head>
<body text="#000000" bgcolor="#FFFFFF" topmargin="0" leftmargin="0" rightmargin="0" onload="init()" >
<form name="form1" method="POST" action="">
<!--검색 지연 창-->
<div id=processing	style='position:absolute;height: 100%;display="none";overflow-x: none; overflow-y: auto; z-index: 5"z-index=999;background-color="#f0fff0";'></div>
<input type="hidden" name="_SCREEN" >
<table width="100%" cellspacing="0" cellpadding="0" border="0"class=loctitle id="table1">
	<tr valign="middle">
		<td width="20"></td>
		<td width="30"><img src="../images/sign_position.gif" alt=""></td>
		<td align="left">반출소스 선택</td>
		<td align="right"><jsp:include page="/common/comHelp.jsp?MU_CD=" flush="false" /></td>
	</tr>
</table>
<table border=1>
<tr height="">
	<td width=20%>
	
	<table width=100% height='1' cellspacing=0 cellpadding=0 border=0  align=left class='trskin'>
	   <TBODY ID="viewtitle">
			<tr height="24" valign="middle" align="center">
			    <td width="100%" class='viewContentH'>레파지토리이름</td>
			</tr>
	   </TBODY>
   </table>
  

<div id="viewlist2" class='listw' style="position:relative;left:0;top:0;width:100%; overflow-x:none; overflow-y:auto;">

	<table width=100%  height='1' cellspacing=0 cellpadding=0 border=0  >	
	<%  
		if(idx!=0 ){
			for(int i=0 ; i<idx ; i++) {
	%>
		<tr ID='chkLine' name='chkLine' height="24" border='0' class="onbase">
			
		<td class="viewContentSL" height="24" width="100"  onClick='viewSource"<%=set.get("WORKSPACE_ID", i)%>")' 
		 onMouseOver="this.className='viewOnL'" onMouseOut="this.className='viewContentSL'"><%=set.get("VIEW_NAME", i)%></td>
		 
	  <%}}else{%><tr><td colspan='20' align='center' height="24">해당 자료가 없습니다.</td></tr>
	  <%}%>
  </table>
 </div>
	
	</td>
	<td width=90%>
		<table width=100% height='1' cellspacing=0 cellpadding=0 border=0  align=left class='trskin'>
		   <TBODY ID="viewtitle">
				<tr height="24" valign="middle" align="center">
				    <td width="30"  class='viewContentH'>선택</td>
					<td width="30"  class='viewContentH' style="display:none;">id</td>
					<td width="200"  class='viewContentH'>소스명</td>
					<td width="280"  class='viewContentH'>경 로</td>
					<td width="30"  class='viewContentH'>버전</td>
					<td width="60"  class='viewContentH'>반출여부</td>
					<td width="70"  class='viewContentH'>파일크기</td>
					<td width="110"  class='viewContentH'>파일생성일</td>
					<td width="70"  class='viewContentH'>파일생성자</td>
					<td width="70"  class='viewContentH' style="display:none;">WORKSPACE_ID</td>
					<td width="70"  class='viewContentH' style="display:none;">승인상태</td>
				</tr>
		   </TBODY>
   		</table>
   		
   		<div id="viewlist2" class='listw' style="position:relative;left:0;top:0;width:100%; overflow-x:none; overflow-y:auto;">

	<table width=100%  height='1' cellspacing=0 cellpadding=0 border=0  >	
	<%  
		if(idx!=0 ){
			for(int i=0 ; i<idx ; i++) {
	%>
		<tr ID='chkLine' name='chkLine' height="24" border='0' class="onbase">
			
		 <td class="viewContentC" height="24" width="30" ><input type="checkbox" id="IS_CHECKED" name="IS_CHECKED"></td>
		 <td class="viewContentC" height="24" width="30" style="display:none;"><%=set.get("WORKSPACE_ID", i)%></td>
		 <td class="viewContentC" height="24" width="200" ><%=set.get("WORKSPACE_ID", i)%></td>
		 <td class="viewContentC" height="24" width="280" ><%=set.get("WORKSPACE_ID", i)%></td>
		 <td class="viewContentC" height="24" width="30" ><%=set.get("WORKSPACE_ID", i)%></td>
		 <td class="viewContentC" height="24" width="60" ><%=set.get("WORKSPACE_ID", i)%></td>
		 <td class="viewContentC" height="24" width="70" ><%=set.get("WORKSPACE_ID", i)%></td>
		 <td class="viewContentC" height="24" width="110" ><%=set.get("WORKSPACE_ID", i)%></td>
		 <td class="viewContentC" height="24" width="70" ><%=set.get("WORKSPACE_ID", i)%></td>
		 <td class="viewContentC" height="24" width="70" style="display:none;"><%=set.get("WORKSPACE_ID", i)%></td>
		 <td class="viewContentC" height="24" width="70" style="display:none;"><%=set.get("WORKSPACE_ID", i)%></td>
		 
	  <%}}else{%><tr><td colspan='20' align='center' height="24">해당 자료가 없습니다.</td></tr>
	  <%}%>
  </table>
 </div>
	</td>
</tr>
  </table>
  
  
</form>
</body>
<script language="javascript">
	setDivSize(100,"viewlist"); //div사이즈 조절
</script>
</html>
