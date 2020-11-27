

<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl"	uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>

<link rel="stylesheet" href="styles/main.css" type="text/css">
<link rel="stylesheet" href="styles/main3.css" type="text/css">


<body style= "background-image: url('images/fondo5.jpg');">

<security:authorize access="isAnonymous()">

	
<div>

<div style= "float:left; margin-left:100px;">
<tag:welcome code="welcome.welcome"/>	
<br />	
<br />
<tag:summary code="welcome.summary"/>
</div>

<form:form>


<tag:login code="welcome.login" url="security/login.do" />	
<br />	
<tag:signup code="welcome.signup" url="register/createUser.do" />	
	

</form:form>
</div>


</security:authorize>
<security:authorize access="hasRole('USER')">

<div class="slider">
			<ul>
				<li>
  <img class="gallery w3-animate-left" src="images/g1.jpg" style="weight:550px; height: 510px;">
 </li>
				<li>
  <img class="gallery w3-animate-right" src="images/g2.jpg" style="weight:550px; height: 510px">
</li>
				<li>
  <img class="gallery w3-animate-left" src="images/g3.jpg" style="weight:550px; height: 510px">
</li>
				<li>
  <img class="gallery w3-animate-right" src="images/g4.jpg" style="weight:550px; height: 510px">
</li>
			</ul>
		</div>

</security:authorize>

<security:authorize access="hasRole('ADMIN')">

<div>
<img src="images/T.jpg" style="weight:550px; height: 550px">

</div>

</security:authorize>
</body>
