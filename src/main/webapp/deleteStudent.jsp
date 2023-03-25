<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.sql.*"%>

<%
    //json simple added in the build.gradle
    JSONArray list = new JSONArray();

    Integer id = Integer.valueOf(request.getParameter("id"));

    Connection conn;
    PreparedStatement pst;

    try {
        JSONObject obj = new JSONObject();
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/student", "root", "");
        pst = conn.prepareStatement("delete from records where id = ?");
        pst.setInt(1, id);
        pst.execute();

        obj.put("result", "delete");
        list.add(obj);
        out.println(list.toJSONString());
        out.flush();
    } catch (Exception ex) {
        response.getWriter().println("<h1>" + ex.getMessage() + "</h1>");
        out.println("<h1>" + ex.getMessage() + "</h1>");
        ex.printStackTrace();
    }
%>