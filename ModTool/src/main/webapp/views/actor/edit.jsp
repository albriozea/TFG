<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>


<link rel="stylesheet" href="styles/edit.css" type="text/css">

<body style= "background-image: url('images/fondo5.jpg');">

<form:form action="profile/${actionURI }"
	modelAttribute="${authority}">

	<form:hidden path="id" />
	<form:hidden path="version" />
	
	<tag:textbox code="actor.name" path="name" obligatory="true"/>
	<br />
	<tag:textbox code="actor.surnames" path="surnames" obligatory="true"/>
	<br />
	<tag:textbox code="actor.email" path="email" obligatory="true" size="35" />
	<br />
	<br />
	<tag:submit name="save" code="actor.save"/>	
	<br />	
	<br />	
	<tag:back2 code="actor.cancel" url="profile/displayPrincipal.do" />

</form:form>
</body>
