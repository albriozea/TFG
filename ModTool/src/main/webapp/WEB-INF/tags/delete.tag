

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

<%@ attribute name="code" required="true" %>
<%@ attribute name="confirmation" required="false" %>

<%-- Definition --%>

<jstl:choose>
	<jstl:when test="${confirmation!=null }">
		<input type="submit" name="delete"
		value="<spring:message code="${code}" />"
		onclick="return confirm('<spring:message code="${confirmation}" />')" />
	</jstl:when>
	<jstl:otherwise>
		<input type="submit" name="delete"
		value="<spring:message code="${code}" />" />
	</jstl:otherwise>
</jstl:choose>
