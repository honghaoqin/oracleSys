<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CKEditor Sample</title>
<script src="${ctx}/plugin/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" href="${ctx}/plugin/ckeditor/samples/sample.css">
</head>
<body>

	<textarea cols="80" id="editor1" name="editor1" rows="10">网页修改器</textarea>
	<script>
       CKEDITOR.replace('editor1');
 
		</script>
      <!-- 
       CKEDITOR.replace( 'editor1', {
				uiColor: '#14B8C4',
				toolbar: [
					[ 'Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink' ],
					[ 'FontSize', 'TextColor', 'BGColor' ]
				]
			});
			 -->
</body>
</html>



