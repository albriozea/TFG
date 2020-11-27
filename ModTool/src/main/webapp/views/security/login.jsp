

<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>

<link rel="stylesheet" href="styles/log.css" type="text/css">

<body style= "background-image: url('images/fondo5.jpg');">

<form:form action="j_spring_security_check" modelAttribute="credentials">

	
	<form:label path="username">
		<spring:message code="security.username" />
	</form:label>
	<br/>
	<form:input path="username" />	
	<form:errors class="error" path="username" />
	<br />

	<form:label path="password">
		<spring:message code="security.password" />
	</form:label>
	<br/>
	<form:password path="password" />	
	<form:errors class="error" path="password" />
	<br />
	
	<jstl:if test="${showError == true}">
		<div class="error">
			<spring:message code="security.login.failed" />
		</div>
	</jstl:if>
	
	<input type="submit" value="<spring:message code="security.login" />" />
	
</form:form>

<tag:back code="actor.back" url="welcome/index.do" />

</body>
