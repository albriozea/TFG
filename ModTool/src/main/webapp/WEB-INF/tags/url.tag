
 
<%@ tag language="java" body-content="empty" %>
 
 <%-- Taglibs --%>

<%@ taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<%-- Attributes --%> 
 
<%@ attribute name="href" required="true" %>
<%@ attribute name="code" required="true" %>

<%-- Definition --%>

<display:column style="font-weight: bold; background-color: #605ca1; color:white; font-family: Arial, Helvetica, sans-serif; text-align: center;">
	<a href="${href }" style="font-weight: bold; background-color: #605ca1; color:white; font-family: Arial, Helvetica, sans-serif; text-align: center;"><spring:message code="${code }"/></a>
</display:column>



