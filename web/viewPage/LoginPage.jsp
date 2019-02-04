<%--
  Created by IntelliJ IDEA.
  User: tiziana
  Date: 01/02/19
  Time: 17.29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="InitModel"
             class="Beans.InitModelBean"
             scope="session"/>

<jsp:useBean id="RequestModel"
             class="Beans.RequestModelBean"
             scope="session"/>

<jsp:useBean id="SubmitModel"
             class="Beans.SubmitModelBean"
             scope="session"/>

<html>
  <head>
    <title>$Login Page$</title>
  </head>
  <h1>
  Login
  </h1>

  <form action="../viewPage/ContractManagementPage.jsp">
    <input type="text" name="user" required>
  <div class="input-group mb-3" >
    <div class="input-group-append" >
      <button class="btn btn-outline-secondary" type="submit" id="button-addon2">Login</button>
    </div>
  </div>
  </form>
</html>
