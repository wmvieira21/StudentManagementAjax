<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.sql.*"%>

<%
    //json simple added in the build.gradle
    JSONArray list = new JSONArray();

    String stdNamme = request.getParameter("stdName");
    String course = request.getParameter("course");
    String fee = request.getParameter("fee");
    Integer id = Integer.valueOf(request.getParameter("id"));

    Connection conn;
    PreparedStatement pst;

    try {
        JSONObject obj = new JSONObject();
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/student", "root", "");

        pst = conn.prepareStatement("update records set name=?, course=?, fee=? where id = ?");
        pst.setString(1, stdNamme);
        pst.setString(2, course);
        pst.setString(3, fee);
        pst.setInt(4, id);
        pst.executeUpdate();

        obj.put("result", "update");
        list.add(obj);
        out.println(list.toJSONString());
        out.flush();
    } catch (Exception ex) {
        response.getWriter().println("<h1>" + ex.getMessage() + "</h1>");
        out.println("<h1>" + ex.getMessage() + "</h1>");
        ex.printStackTrace();
    }
%>