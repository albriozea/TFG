

<%@ tag language="java" body-content="empty" %>

<%-- Taglibs --%>

<%@ taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>

<%-- Attributes --%> 
 
<%@ attribute name="path" required="true" rtexprvalue="true" %>
<%@ attribute name="code" required="true" rtexprvalue="true" %>

<%@ attribute name="obligatory" required="false" %>

<jstl:if test="${obligatory == null}">
	<jstl:set var="obligatory" value="false" />
</jstl:if>

<%-- Definition --%>

<div>
	<form:label path="${path}">
		<jstl:choose> 
			<jstl:when test="${obligatory }">
			<spring:message code="${code}" />*
			</jstl:when>
			<jstl:when test="${!obligatory }">
			<spring:message code="${code}" />
			</jstl:when>
		</jstl:choose>
	</form:label>
	<form:password path="${path}"/>
	<form:errors path="${path}" cssClass="error" />
</div>