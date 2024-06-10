package DAO;

import DTO.BOOKMARK_LISTDTO;
import wifi.DB;
import wifi.JDBCT;
import DTO.BOOKMARK_GROUPDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BOOKMARK_GROUPDAO extends JDBCT {
    public int insert(BOOKMARK_GROUPDTO bookmarkGroupDTO) {
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

            String sql = "INSERT INTO BOOKMARK_GROUP (NAME, SEQUENCE, REGISTER_DTTM) VALUES (?, ?, datetime('now', 'localtime'));";

            ps = c.prepareStatement(sql);
            ps.setString(1, bookmarkGroupDTO.getNAME());
            ps.setInt(2, bookmarkGroupDTO.getSEQUENCE());

            affected = ps.executeUpdate();
            if (affected > 0) {
                System.out.println("북마크 그룹 데이터 삽입 성공");
            } else {
                System.out.println("북마크 그룹 데이터 삽입 실패");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(ps);
            close(c);
        }
        return affected;
    }

    public BOOKMARK_GROUPDTO select(int ID) {
        BOOKMARK_GROUPDTO bookmarkGroupDto = new BOOKMARK_GROUPDTO();

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

            String sql = "SELECT * FROM BOOKMARK_GROUP WHERE ID = ?;";

            ps = c.prepareStatement(sql);
            ps.setInt(1, ID);

            rs = ps.executeQuery();
            while (rs.next()) {
                int ID1 = rs.getInt("ID");
                String NAME = rs.getString("NAME");
                int SEQUENCE = rs.getInt("SEQUENCE");
                Date REGISTER_DT = rs.getDate("REGISTER_DT");
                Date UPDATE_DT= rs.getDate("UPDATE_DT");

                bookmarkGroupDto.setID(ID1);
                bookmarkGroupDto.setNAME(NAME);
                bookmarkGroupDto.setSEQUENCE(SEQUENCE);
                bookmarkGroupDto.setREGISTER_DT(REGISTER_DT);
                bookmarkGroupDto.setUPDATE_DT(UPDATE_DT);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(ps);
            close(c);
        }
        return bookmarkGroupDto;
    }

    public int delete(int ID) {
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

            ps = conn.prepareStatement("PRAGMA foreign_keys = ON;");
            ps.executeUpdate();

            String sql = "DELETE FROM BOOKMARK_GROUP WHERE ID = ?;";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, ID);

            affected = ps.executeUpdate();
            if (affected > 0) {
                System.out.println("북마크 그룹 데이터 삭제 성공");
            } else {
                System.out.println("북마크 그룹 데이터 삭제 실패");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(ps);
            close(conn);
        }
        return affected;
    }

    public int update(BOOKMARK_GROUPDTO bookmarkGroupDto) {
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

            String sql = "UPDATE BOOKMARK_GROUP SET NAME = ?, SEQUENCE = ?, UPDATE_DTTM = datetime('now', 'localtime') WHERE ID = ?;";

            ps = c.prepareStatement(sql);
            ps.setString(1, bookmarkGroupDto.getNAME());
            ps.setInt(2, bookmarkGroupDto.getSEQUENCE());
            ps.setInt(3, bookmarkGroupDto.getID());

            affected = ps.executeUpdate();
            if (affected > 0) {
                System.out.println("북마크 그룹 데이터 업데이트 성공");
            } else {
                System.out.println("북마크 그룹 데이터 업데이트 실패");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(ps);
            close(c);
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

        Connection c = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            c = DriverManager.getConnection(DB.URL);

            String sql = "SELECT COUNT(*) FROM BOOKMARK_GROUP;";

            ps = c.prepareStatement(sql);

            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(ps);
            close(c);
        }
        return count;
    }

    public List<BOOKMARK_GROUPDTO> selectList() {
        List<BOOKMARK_GROUPDTO> bookmarkGroupDtoList = new ArrayList<>();

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

            String sql = "SELECT * FROM BOOKMARK_GROUP ORDER BY ID";

            ps = c.prepareStatement(sql);

            rs = ps.executeQuery();
            while (rs.next()) {
                int ID = rs.getInt("ID");
                String NAME = rs.getString("NAME");
                int SEQUENCE = rs.getInt("SEQUENCE");
                Date REGISTER_DT = rs.getDate("REGISTER_DT");
                Date UPDATE_DT = rs.getDate("UPDATE_DT");

                BOOKMARK_GROUPDTO bookmarkGroupDTO = new BOOKMARK_GROUPDTO();
                bookmarkGroupDTO.setID(ID);
                bookmarkGroupDTO.setNAME(NAME);
                bookmarkGroupDTO.setSEQUENCE(SEQUENCE);
                bookmarkGroupDTO.setREGISTER_DT(REGISTER_DT);
                bookmarkGroupDTO.setUPDATE_DT(UPDATE_DT);

                bookmarkGroupDtoList.add(bookmarkGroupDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(ps);
            close(c);
        }
        return bookmarkGroupDtoList;
    }
}