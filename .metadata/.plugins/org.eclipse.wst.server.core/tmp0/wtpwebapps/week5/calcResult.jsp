<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="calc" class="week5.Calculator"></jsp:useBean>
<jsp:setProperty property="*" name="calc"/>

<h3>결과 출력</h3>
<%=calc.getNum1() %><%=calc.getOp() %><%=calc.getNum2() %>=<%=calc.calculate() %>

</body>
</html>