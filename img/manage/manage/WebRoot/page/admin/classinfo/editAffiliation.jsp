<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<jsp:include page="../../../inc.jsp"></jsp:include>
		<script type="text/javascript">
		$(function() {
			if ($('#classId').val() > 0) {
				$.ajax({
					url : '${pageContext.request.contextPath}/classInfo/classInfoAction!viewAffiliation.action',
					data : $('form').serialize(),
					dataType : 'json',
					success : function(result) {
						if (result.class_id != undefined) {
							$('form').form('load', {
								'classInfo.schoolName' : result.schoolName,
								'classInfo.college' : result.college,
								'classInfo.major' : result.major,
								'classInfo.affiliation' : result.affiliation
							});
						}

                        var data = $('#select_dept').combobox('getData');
                        data.push({'department_id':'0','departmentName':'---'});
                        $('#select_dept').combobox('loadData', data);
					},
					beforeSend:function(){
						parent.$.messager.progress({
							text : '数据加载中....'
						});
					},
					complete:function(){
						parent.$.messager.progress('close');
					}
				});
			}
		});
		var submitForm = function($dialog, $grid, $pjq) {
			if ($('form').form('validate')) {
				var url;
				if ($('#classId').val() > 0) {
					url = '${pageContext.request.contextPath}/classInfo/classInfoAction!updateAffiliation.action';
				}
				$.ajax({
					url : url,
					data : $('form').serialize(),
					dataType : 'json',
					success : function(result) {
						if (result.success) {
							$grid.datagrid('reload');
							$dialog.dialog('destroy');
							$pjq.messager.alert('提示', result.msg, 'info');
						} else {
							$pjq.messager.alert('提示', result.msg, 'error');
						}
					},
					beforeSend:function(){
						parent.$.messager.progress({
							text : '数据提交中....'
						});
					},
					complete:function(){
						parent.$.messager.progress('close');
					}
				});
			}
		};
		</script>
	</head>

	<body>
		<form method="post" class="form">
		<input name="classInfo.class_id" type="hidden" id="classId" value="${param.id}">
			<fieldset>
				<legend>
					专业信息
				</legend>
				<table class="ta001">
					<tr>
						<th>
							学校
						</th>
						<td>
							<input name="classInfo.schoolName" class="easyui-validatebox"
								data-options="required:true,validType:'customRequired'" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<th>
							院系
						</th>
						<td>
							<input name="classInfo.college" class="easyui-validatebox"
								data-options="required:true,validType:'customRequired'" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<th>
							专业
						</th>
						<td>
							<input name="classInfo.major" class="easyui-validatebox"
								data-options="required:true,validType:'customRequired'" disabled="disabled"/>
						</td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
				<legend>
					隶属设置
				</legend>
				<table class="ta001">
					<tr>
						<th align="right">
							隶属当前院系
						</th>
						<td >
							<input class="easyui-combobox" name="classInfo.affiliation" style="width: 150px;" id="select_dept"
										data-options="
					                    url:'${pageContext.request.contextPath}/department/departmentAction!getProjectName.action',
					                    method:'post',
					                    valueField:'department_id',
					                    textField:'departmentName',
					                    editable:false
				                    	">
						</td>
					</tr>
				</table>
			</fieldset>
		</form>
	</body>
</html>