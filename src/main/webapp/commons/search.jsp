<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
查询文字匹配模式:
<INPUT type="radio" value="=" id="xxx_matchmode_1" name="formMap.xxx_matchmode" <c:if test = "${formMap.xxx_matchmode == '='}">CHECKED</c:if>><label for="xxx_matchmode_1">精确&nbsp;</label>
<INPUT type="radio" value="llike" id="xxx_matchmode_2" name="formMap.xxx_matchmode" <c:if test = "${formMap.xxx_matchmode == 'llike'}">CHECKED</c:if>><label for="xxx_matchmode_2">左匹配&nbsp;</label>
<INPUT type="radio" value="rlike" id="xxx_matchmode_3" name="formMap.xxx_matchmode" <c:if test = "${formMap.xxx_matchmode == 'rlike'}">CHECKED</c:if>><label for="xxx_matchmode_3">右匹配&nbsp;</label>
<INPUT type="radio" value="like" id="xxx_matchmode_4" name="formMap.xxx_matchmode" <c:if test = "${formMap.xxx_matchmode == 'like' || formMap.xxx_matchmode == null}">CHECKED</c:if>><label for="xxx_matchmode_4">模糊匹配&nbsp;&nbsp;&nbsp;&nbsp;</label>