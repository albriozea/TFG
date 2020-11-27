<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>

<link rel="stylesheet" href="styles/listPro.css" type="text/css">

<body style= "background-image: url('images/fondo5.jpg'); color: white;  font-weight: bold;">
<div style="color: black; font-family: Arial, Helvetica, sans-serif; margin: 10% auto 14% auto; margin-left: 20%;">
<display:table name="actors" id="row" requestURI="${requestURI }" pagesize="5" style="color: white; background-color: black;">

	<tag:column property="name" titleKey="actor.name" value= "${row.name}: "/>
	
	<tag:column property="surnames" titleKey="actor.surnames" value= "${row.surnames}: "/>
	
	<tag:column property="email" titleKey="actor.email" value= "${row.email}: "/>
	
	
</display:table>

</div>

<tag:back code="actor.back" url="welcome/index.do" />

</body>