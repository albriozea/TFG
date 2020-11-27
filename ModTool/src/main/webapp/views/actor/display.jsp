<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>


<link rel="stylesheet" href="styles/disp.css" type="text/css">

<body style= "background-image: url('images/fondo5.jpg');">

<form:form>

<tag:display code="actor.name" property="${actor.name }" />
<br />	
<tag:display code="actor.surnames" property="${actor.surnames }" />
<br />	
<tag:display code="actor.email" property="${actor.email }" />
<br />	

	<security:authorize access="isAuthenticated()">
		
		<tag:edit code="actor.edit" url="profile/edit.do" />

	</security:authorize>

<br />	
<br />	
	<tag:back2 code="actor.back" url="welcome/index.do" />

</form:form>
</body>
	

