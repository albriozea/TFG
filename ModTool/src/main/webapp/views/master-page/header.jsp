

<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<link rel="stylesheet" href="styles/jmenu.css" media="screen" type="text/css" />

<div>
	<ul id="jMenu">
		<!-- Do not forget the "fNiv" class for the first level links !! -->
		<security:authorize access="hasRole('ADMIN')">
			<li><a class="fNiv"><spring:message	code="master.page.administrator" /></a>
				<ul>
					<li class="arrow"></li>
					<li><a href="actor/administrator/profile/list.do"><spring:message code="master.page.profiles" /></a></li>
					
					
					
				</ul>
			</li>
		</security:authorize>
		
		<security:authorize access="hasRole('USER')">
			<li><a class="fNiv"><spring:message	code="master.page.user" /></a>
				<ul>
					<li class="arrow"></li>
					<li><a href="canvas/user/display.do"><spring:message code="master.page.canvas" /></a></li>

				</ul>
			</li>
		</security:authorize>
		
	
		<security:authorize access="isAnonymous()">
			<li><a class="fNiv"/></a></li>
		</security:authorize>
		
		<security:authorize access="permitAll()">

		</security:authorize>	
		
		<security:authorize access="isAuthenticated()">
			<li>
				<a class="fNiv"> 
					<spring:message code="master.page.profile" /> 
			        (<security:authentication property="principal.username" />)
				</a>
				<ul>
					<li><a href="profile/displayPrincipal.do"><spring:message code="master.page.profile" /></a></li>
					<li><a href="j_spring_security_logout"><spring:message code="master.page.logout" /> </a></li>
				</ul>
			</li>
		</security:authorize>	
	</ul>	
</div>	

<div class=flags style= "position: absolute; right: 20px; top:20px">
	<a href="?language=es"><img border="0" src="images/spa.png" width="30" height="30"></a> | <a href="?language=en"><img border="0" src="images/eng.png" width="30" height="30"></a>
</div>

