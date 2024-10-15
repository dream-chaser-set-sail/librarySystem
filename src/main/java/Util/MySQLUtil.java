package Util;


import Bean.Admin;
import Bean.BorrowCard;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class MySQLUtil {
    // 注意，如果这个方法会有多个进程访问，就不要写全局变量，为了避免访问冲突应该改为局部变量

    /**
     * SELECT: 用于查询SQL数据
     * 参数 =>
     * sql ==> SQL语句
     * clazz ==> 用于接收数据的Bean类
     * DataList ==> 传入的'?'的值
     * ...args ==> 可变参数[]
     *
     * @param sql
     * @param clazz
     * @param DataList
     * @param args
     * @return List<T>
     * @param <T>
     */
    public static <T> List<T> SELECT(String sql, Class<T> clazz, List<Object> DataList, Object...args){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        List<T> list = new ArrayList<>();
        try {
            connection = JDBCTool.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            if (args != null){
                for (int i = 0; i < args.length; i++) {
                    System.out.println(args[i]);
                    preparedStatement.setObject(i+1, args[i]);
                }
            }

            if (DataList != null){
                for (int i = 0; i < DataList.size(); i++) {
                    System.out.println(DataList.get(i));
                    preparedStatement.setObject(i+1, DataList.get(i));
                }
            }
            System.out.println(preparedStatement);
            resultSet = preparedStatement.executeQuery();
            ResultSetMetaData metaData = resultSet.getMetaData();
//            查询出的列数
            int columnCount = metaData.getColumnCount();
            while (resultSet.next()){
                //新建反射对象
                T t = clazz.getDeclaredConstructor().newInstance();
//                表有几列就循环几次
                for (int i = 0; i < columnCount; i++) {
                    // 要求属性名一致
                    //列的值
                    Object value = resultSet.getObject(i + 1);
                    //列名
                    String columnLabel = metaData.getColumnLabel(i + 1);
                    //对应属性
                    Field declaredField = clazz.getDeclaredField(changeName(columnLabel));
                    // 处理日期时间字段
                    if (value.getClass().toString().equalsIgnoreCase("class java.time.LocalDateTime")) {
                        value = Timestamp.valueOf((LocalDateTime) value);
                    }
                    //可访问私有
                    declaredField.setAccessible(true);
                    //映射值
                    declaredField.set(t,value);
                }
                list.add(t);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (InstantiationException e) {
            throw new RuntimeException(e);
        } catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        } catch (NoSuchFieldException e) {
            throw new RuntimeException(e);
        } catch (InvocationTargetException e) {
            throw new RuntimeException(e);
        } catch (NoSuchMethodException e) {
            throw new RuntimeException(e);
        }
        return list;
    }


    /**
     * UPDATE: 用于增删改SQL数据
     * 参数: =>
     * sql ==> SQL语句
     * list ==> 传入的'?'的值
     * ...args ==> 可变参数[]
     *
     * @param sql
     * @param list
     * @param args
     * @return Boolean
     */
    public static Boolean UPDATE(String sql, List<Object> list, Object...args){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        int num = 0;
        boolean isUpdate = false;
        try {
            connection = JDBCTool.getConnection();
            preparedStatement = connection.prepareStatement(sql);

            if (list != null){
                for (int i = 0; i < list.size(); i++) {
                    preparedStatement.setObject(i+1, list.get(i));
                }
            }

            if (args != null){
                for (int i = 0; i < args.length; i++) {
                    preparedStatement.setObject(i+1, args[i]);
                }
            }
            System.out.println(preparedStatement);
            num = preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            JDBCTool.close(connection,preparedStatement,resultSet);
        }

        if (num != 0){
            isUpdate = true;
        }

        return isUpdate;
    }

    /**
     * AS代表别名，但是语句里也要加上别名
     * @param sql
     * @param list
     * @param AS
     * @param args
     * @return Integer
     */
    public static Integer SELECTCOUNT(String sql, List<Object> list, String AS, Object...args){
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        int num = 0;

        try {
            connection = JDBCTool.getConnection();
            preparedStatement = connection.prepareStatement(sql);

            if (list != null){
                for (int i = 0; i < list.size(); i++) {
                    preparedStatement.setObject(i+1, list.get(i));
                }
            }

            if (args != null){
                for (int i = 0; i < args.length; i++) {
                    preparedStatement.setObject(i+1, args[i]);
                }
            }
            System.out.println(preparedStatement);
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                if (!"".equalsIgnoreCase(AS) && AS != null){
                    num = resultSet.getInt(AS);
                }else {
                    num = resultSet.getInt("COUNT(*)");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            JDBCTool.close(connection,preparedStatement,resultSet);
        }

        return num;
    }

    /**
     * changeName
     * 处理下划线转驼峰
     * @param name
     * @return String
     */
    private static String changeName(String name){
        String Iname = name;
        int index = Iname.indexOf("_");
        if (index > 0 && Iname.length() != index + 1){
            Iname = Iname.replaceFirst("_", "");
            String substring = Iname.substring(index, index + 1);
            substring = substring.toUpperCase();
            name = Iname.substring(0,index) + substring + Iname.substring(index + 1);
        }else {
            return name;
        }

        return changeName(name);
    }


    /**
     * 查询单一数据用...
     * @param sql
     * @param clazz
     * @param args
     * @return class
     * @param <T>
     */
    public static <T> T SELECTone(String sql, Class<T> clazz, Object...args) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        T instance = null;
        try {
            // 1. 创建数据库连接
            connection = JDBCTool.getConnection();
            preparedStatement = connection.prepareStatement(sql);

            // 2. 设置 SQL 参数
            if (args != null) {
                for (int i = 0; i < args.length; i++) {
                    preparedStatement.setObject(i + 1, args[i]);
                }
            }

            // 打印SQL语句
            System.out.println(preparedStatement);

            // 3. 执行查询
            resultSet = preparedStatement.executeQuery();
            ResultSetMetaData metaData = resultSet.getMetaData();
            int columnCount = metaData.getColumnCount();

            // 4. 处理结果集
            if (resultSet.next()) {  // 处理结果集的第一条记录
                instance = clazz.getDeclaredConstructor().newInstance();
                for (int i = 0; i < columnCount; i++) {
                    // 获取列值和列名
                    Object value = resultSet.getObject(i + 1);
                    String columnLabel = metaData.getColumnLabel(i + 1);

                    // 获取字段
                    Field field = clazz.getDeclaredField(changeName(columnLabel));

                    // 处理日期时间字段
                    if (value != null && value.getClass().equals(LocalDateTime.class)) {
//                        折中一下,转为Timestamp
                        Timestamp timestamp = Timestamp.valueOf((LocalDateTime) value);
                        value = timestamp;
                    }

                    // 设置字段可访问
                    field.setAccessible(true);
                    // 设置字段值
                    field.set(instance, value);
                }
            }
        } catch (SQLException | InstantiationException | IllegalAccessException | NoSuchFieldException |
                 NoSuchMethodException | InvocationTargetException e) {
            throw new RuntimeException(e);
        } finally {
            JDBCTool.close(connection,preparedStatement,resultSet);
        }

        // 5. 返回对象
        return instance;
    }

    public static void main(String[] args) {
//        String s = changeName("admin_status");
//        System.out.println(s);

        String sql = "SELECT admin_card_num FROM admin WHERE admin_card_num = ?";
        Admin admin = SELECTone(sql, Admin.class, "75839244112");
        System.out.println(admin);
    }
}
