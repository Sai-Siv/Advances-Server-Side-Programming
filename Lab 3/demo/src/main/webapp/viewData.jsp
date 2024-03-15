<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    // JavaBean to represent data
    class DataBean {
        private String field1;
        private String field2;
        private String field3;
        private String field4;
        private String field5;

        // Getter and Setter methods

        public String getField1() {
            return field1;
        }

        public void setField1(String field1) {
            this.field1 = field1;
        }

        public String getField2() {
            return field2;
        }

        public void setField2(String field2) {
            this.field2 = field2;
        }

        public String getField3() {
            return field3;
        }

        public void setField3(String field3) {
            this.field3 = field3;
        }

        public String getField4() {
            return field4;
        }

        public void setField4(String field4) {
            this.field4 = field4;
        }

        public String getField5() {
            return field5;
        }

        public void setField5(String field5) {
            this.field5 = field5;
        }
    }

    // Retrieve data from the database and store in a List of DataBean
    List<DataBean> dataBeans = new ArrayList<>();

    try {
        String url = "jdbc:mysql://localhost:3305/LAB";
        String user = "ssss";
        String password = "ssss";
        Connection conn = DriverManager.getConnection(url, user, password);

        String sql = "SELECT * FROM test";
        PreparedStatement statement = conn.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {
            DataBean dataBean = new DataBean();
            dataBean.setField1(resultSet.getString("field1"));
            dataBean.setField2(resultSet.getString("field2"));
            dataBean.setField3(resultSet.getString("field3"));
            dataBean.setField4(resultSet.getString("field4"));
            dataBean.setField5(resultSet.getString("field5"));
            dataBeans.add(dataBean);
        }

        resultSet.close();
        statement.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    // Handle delete action
    String deleteParam = request.getParameter("delete");
    if (deleteParam != null && deleteParam.equals("true")) {
        if (!dataBeans.isEmpty()) {
            DataBean firstDataBean = dataBeans.remove(0); // Remove the first row
            try {
                String url = "jdbc:mysql://localhost:3305/LAB";
                String user = "ssss";
                String password = "ssss";
                Connection conn = DriverManager.getConnection(url, user, password);

                String deleteSql = "DELETE FROM test WHERE field1 = ?";
                PreparedStatement deleteStatement = conn.prepareStatement(deleteSql);
                deleteStatement.setString(1, firstDataBean.getField1());
                deleteStatement.executeUpdate();

                deleteStatement.close();
                conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
%>

<html>
<head>
    <title>View Data</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

<h2>View Data</h2>

<form method="post" action="">
    <input type="hidden" name="delete" value="true">
    <input type="submit" value="Delete First Row">
</form>

<table>
    <tr>
        <th>Field1</th>
        <th>Field2</th>
        <th>Field3</th>
        <th>Field4</th>
        <th>Field5</th>
    </tr>

    <%
        for (DataBean dataBean : dataBeans) {
    %>
        <tr>
            <td><%= dataBean.getField1() %></td>
            <td><%= dataBean.getField2() %></td>
            <td><%= dataBean.getField3() %></td>
            <td><%= dataBean.getField4() %></td>
            <td><%= dataBean.getField5() %></td>
        </tr>
    <%
        }
    %>
</table>

</body>
</html>
