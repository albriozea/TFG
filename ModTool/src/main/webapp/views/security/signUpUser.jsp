<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>


<link rel="stylesheet" href="styles/sign.css" type="text/css">

<body style= "background-image: url('images/fondo5.jpg');">

<form:form action="register/saveUser.do" modelAttribute="user">
	
	
	<tag:textbox code="actor.name" path="name" obligatory="true"/>
	
	<tag:textbox code="actor.surnames" path="surnames" obligatory="true"/>
	
	<tag:textbox code="actor.email" path="email" obligatory="true" size="35"/>
	
	<tag:textbox code="actor.username" path="username" obligatory="true"/>
	
	<tag:password code="actor.password" path="password" obligatory="true"/>
	
	<tag:password code="actor.confirmPassword" path="confirmPassword" obligatory="true"/>	
	
	
	<jstl:if test="${showError == true}">
		<div class="error">
			<spring:message code="user.commit.error" />
		</div>
	</jstl:if>
	
	<input type="submit" name="save" value="<spring:message code="actor.save" />" />
	
	
	
</form:form>

<tag:back code="actor.back" url="welcome/index.do" />



<jstl:if test="${message!=null }">
	<div class="error"><spring:message code="user.commit.error" /></div>
</jstl:if> 

</body>
