

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

<%@ attribute name="path" required="true" %>
<%@ attribute name="code" required="true" %>
<%@ attribute name="value1" required="true" %>
<%@ attribute name="value2" required="true" %>
<%@	attribute name="label1" required="true" %>
<%@ attribute name="label2" required="true" %>
<%@ attribute name="readonly" required="false" %>



<%-- Definition --%>

<jstl:if test="${readonly == null}">
	<jstl:set var="readonly" value="false" />
</jstl:if>

<form:label path="${path}">
		<spring:message code="${code}" />
	</form:label>	
	<form:select path="${path}">
       <form:option value="${value1 }" label="${label1}" />
       <form:option value="${value2 }" label="${label2}" />
 </form:select>
 <form:errors cssClass="error" path="${path }"></form:errors>