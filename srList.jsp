<!--
	 �� �� ��  : srList.jsp
	 �ۼ�����  : 2016-04-06
	 �� �� ��  : mailbest
	 ��    ��  : SR��û ��ȸ����Ʈ
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
	request.setAttribute("setString", "Y");//parameter�� �÷������� �����Ҷ� ���

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
	//combobox �ʱ�ȭ
	fn_combo('S_SR_SYSTEM',new Array(frm.Fr_yymm.value,frm.To_yymm.value));	//���ý���
	fn_combo('S_SR_TYPE',new Array(frm.Fr_yymm.value,frm.To_yymm.value));	//SR����
	fn_combo('S_SR_DOC_TYPE',new Array(frm.Fr_yymm.value,frm.To_yymm.value));	//�����ܰ�
	fn_combo('S_SR_CONF_TYPE',new Array(frm.Fr_yymm.value,frm.To_yymm.value));	//�������
	fn_combo('S_SR_EMPID',new Array(frm.Fr_yymm.value,frm.To_yymm.value));	//��û��
	fn_combo('S_SR_REV_EMPID',new Array(frm.Fr_yymm.value,frm.To_yymm.value));	//�����/������
}
	
function search(){
		var frm = document.form1;
		divSearch(); //����â ���̱�
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
	      divSearch("ó�� �� �Դϴ�."); //�˻� ����â ���̱�
	      alert();
	   frm._SCREEN.value='/CMS/srList.jsp';
	   frm.action='asrMngSave.do';
	   frm.target='_self';
	   frm.submit(); 
 } 
function Excel(){
	 var frm=document.forms[0];
	      divSearch("�����ٿ�ε� �� �Դϴ�."); //�˻� ����â ���̱� 
	   frm.Action='/IpMng/IpMngExcel.jsp';
	   frm.submit(); 
 } 
function viewSource(SR_NO){
	 var frm=document.forms[0];
	   divSearch(); //�˻� ����â ���̱�
	   frm.action='/CMS/srView.jsp?S_SR_NO='+SR_NO;
	   frm.target='_self';
	   frm.submit(); 
 } 
</script>
</head>
<title>������ġ����</title>
</head>
<body text="#000000" bgcolor="#FFFFFF" topmargin="0" leftmargin="0" rightmargin="0" onload="init()" >
<form name="form1" method="POST" action="">
<!--�˻� ���� â-->
<div id=processing	style='position:absolute;height: 100%;display="none";overflow-x: none; overflow-y: auto; z-index: 5"z-index=999;background-color="#f0fff0";'></div>
<input type="hidden" name="_SCREEN" >
<table width="100%" cellspacing="0" cellpadding="0" border="0"class=loctitle id="table1">
	<tr valign="middle">
		<td width="20"></td>
		<td width="30"><img src="../images/sign_position.gif" alt=""></td>
		<td align="left">����ҽ� ����</td>
		<td align="right"><jsp:include page="/common/comHelp.jsp?MU_CD=" flush="false" /></td>
	</tr>
</table>
<table border=1>
<tr height="">
	<td width=20%>
	
	<table width=100% height='1' cellspacing=0 cellpadding=0 border=0  align=left class='trskin'>
	   <TBODY ID="viewtitle">
			<tr height="24" valign="middle" align="center">
			    <td width="100%" class='viewContentH'>�������丮�̸�</td>
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
		 
	  <%}}else{%><tr><td colspan='20' align='center' height="24">�ش� �ڷᰡ �����ϴ�.</td></tr>
	  <%}%>
  </table>
 </div>
	
	</td>
	<td width=90%>
		<table width=100% height='1' cellspacing=0 cellpadding=0 border=0  align=left class='trskin'>
		   <TBODY ID="viewtitle">
				<tr height="24" valign="middle" align="center">
				    <td width="30"  class='viewContentH'>����</td>
					<td width="30"  class='viewContentH' style="display:none;">id</td>
					<td width="200"  class='viewContentH'>�ҽ���</td>
					<td width="280"  class='viewContentH'>�� ��</td>
					<td width="30"  class='viewContentH'>����</td>
					<td width="60"  class='viewContentH'>���⿩��</td>
					<td width="70"  class='viewContentH'>����ũ��</td>
					<td width="110"  class='viewContentH'>���ϻ�����</td>
					<td width="70"  class='viewContentH'>���ϻ�����</td>
					<td width="70"  class='viewContentH' style="display:none;">WORKSPACE_ID</td>
					<td width="70"  class='viewContentH' style="display:none;">���λ���</td>
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
		 
	  <%}}else{%><tr><td colspan='20' align='center' height="24">�ش� �ڷᰡ �����ϴ�.</td></tr>
	  <%}%>
  </table>
 </div>
	</td>
</tr>
  </table>
  
  
</form>
</body>
<script language="javascript">
	setDivSize(100,"viewlist"); //div������ ����
</script>
</html>
