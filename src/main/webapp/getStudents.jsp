<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.sql.*"%>

<%
    //json simple added in the build.gradle
    JSONArray list = new JSONArray();
    Connection conn;
    PreparedStatement pst;

    try {
        JSONObject obj;
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/student", "root", "");
        pst = conn.prepareStatement("select * from records");
        ResultSet resultSet = pst.executeQuery();

        while (resultSet.next()) {
            Integer id = resultSet.getInt("id");
            String name = resultSet.getString("name");
            String course = resultSet.getString("course");
            String fee = resultSet.getString("fee");
            
            obj = new JSONObject();
            obj.put("idBase", id);
            obj.put("nameBase", name);
            obj.put("courseBase", course);
            obj.put("feeBase", fee);
            list.add(obj);
        }

        out.println(list.toJSONString());
        out.flush();
    } catch (Exception ex) {
        response.getWriter().println("<h1>" + ex.getMessage() + "</h1>");
        out.println("<h1>" + ex.getMessage() + "</h1>");
        ex.printStackTrace();
    }
%>