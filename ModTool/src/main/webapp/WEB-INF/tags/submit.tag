

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

<%@ attribute name="name" required="true" %> 
<%@ attribute name="code" required="true" %>

<%-- Definition --%>

<button type="submit" name="${name}" class="btn btn-primary" style= " font-weight: bold; width: 100%; height: 45px; padding: 5px; background-color: #33b857; color: white;">
	<spring:message code="${code}" />
</button>
