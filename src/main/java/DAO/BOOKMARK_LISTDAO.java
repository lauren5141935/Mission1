package DAO;


import wifi.JDBCT;
import DTO.BOOKMARK_LISTDTO;
import wifi.DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BOOKMARK_LISTDAO extends JDBCT {
    public int upsert(BOOKMARK_LISTDTO bookmarklistDTO) {
        try {
            Class.forName(DB.CLASS);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection c = null;
        PreparedStatement ps = null;
        int affected = 0;

        try {
            c = DriverManager.getConnection(DB.URL);

            String sql = "INSERT OR REPLACE INTO BOOKMARK_LIST (GROUP_ID, MGR_NO, REGISTER_DT) VALUES (?, ?, datetime('now', 'localtime'));";

            ps = c.prepareStatement(sql);
            ps.setInt(1, bookmarklistDTO.getGROUP_ID());
            ps.setString(2, bookmarklistDTO.getMGR_NO());

            affected = ps.executeUpdate();
            if (affected > 0) {
                System.out.println("북마크 데이터 삽입 성공");
            } else {
                System.out.println("북마크 데이터 삽입 실패");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(ps);
            close(c);
        }
        return affected;
    }

    public BOOKMARK_LISTDTO select(int ID) {
        BOOKMARK_LISTDTO bookmarklistDTO = new BOOKMARK_LISTDTO();

        try {
            Class.forName(DB.CLASS);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection c = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            c = DriverManager.getConnection(DB.URL);

            String sql = "SELECT * FROM BOOKMARK_LIST WHERE ID = ?;";

            ps = c.prepareStatement(sql);
            ps.setInt(1, ID);

            rs = ps.executeQuery();
            while (rs.next()) {
                int ID1 = rs.getInt("ID");
                int GROUP_ID = rs.getInt("GROUP_ID");
                String MGR_NO = rs.getString("MGR_NO");
                Date REGISTER_DT = rs.getDate("REGISTER_DT");

                bookmarklistDTO.setID(ID1);
                bookmarklistDTO.setGROUP_ID(GROUP_ID);
                bookmarklistDTO.setMGR_NO(MGR_NO);
                bookmarklistDTO.setREGISTER_DT(REGISTER_DT);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(ps);
            close(c);
        }
        return bookmarklistDTO;
    }

    public int delete(int id) {
        try {
            Class.forName(DB.CLASS);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection conn = null;
        PreparedStatement ps = null;
        int affected = 0;

        try {
            conn = DriverManager.getConnection(DB.URL);

            String sql = "DELETE FROM BOOKMARK WHERE ID = ?;";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            affected = ps.executeUpdate();
            if (affected > 0) {
                System.out.println("북마크 데이터 삭제 성공");
            } else {
                System.out.println("북마크 데이터 삭제 실패");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(ps);
            close(conn);
        }
        return affected;
    }

    public int count() {
        int count = 0;

        try {
            Class.forName(DB.CLASS);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DriverManager.getConnection(DB.URL);

            String sql = "SELECT COUNT(*) FROM BOOKMARK_LIST;";

            ps = conn.prepareStatement(sql);

            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(ps);
            close(conn);
        }
        return count;
    }

    public List<BOOKMARK_LISTDTO> selectList() {
        List<BOOKMARK_LISTDTO> BOOKMARK_LISTDAO = new ArrayList<>();

        try {
            Class.forName(DB.CLASS);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection c = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            c = DriverManager.getConnection(DB.URL);

            String sql = "SELECT BOOKMARK_LIST.* " +
                    "FROM BOOKMARK_LIST " +
                    "INNER JOIN BOOKMARK_GROUP " +
                    "ON BOOKMARK.GROUP_ID = BOOKMARK_GROUP.ID " +
                    "ORDER BY BOOKMARK_GROUP.SEQUENCE";

            ps = c.prepareStatement(sql);

            rs = ps.executeQuery();
            while (rs.next()) {
                int ID = rs.getInt("ID");
                int GROUP_ID = rs.getInt("GROUP_ID");
                String MNG_NO = rs.getString("MGR_NO");
                Date REGISTER_DT = rs.getDate("REGISTER_DT");

                BOOKMARK_LISTDTO bookmarklistDTO = new BOOKMARK_LISTDTO();
                bookmarklistDTO.setID(ID);
                bookmarklistDTO.setGROUP_ID(GROUP_ID);
                bookmarklistDTO.setMGR_NO(MNG_NO);
                bookmarklistDTO.setREGISTER_DT(REGISTER_DT);

                BOOKMARK_LISTDAO.add(bookmarklistDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(ps);
            close(c);
        }
        return BOOKMARK_LISTDAO;
    }
}