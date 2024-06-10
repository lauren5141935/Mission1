package DAO;

import wifi.DB;
import wifi.JDBCT;
import DTO.WIFI_HISTORYDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WIFI_HISTORYDAO extends JDBCT {
    public int insert(WIFI_HISTORYDTO wifihistoryDto) {
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

            String sql = "INSERT INTO HISTORY (LAT, LNT, SEARCH_DT) VALUES (?, ?, datetime('now', 'localtime'));";

            ps = c.prepareStatement(sql);
            ps.setDouble(1, wifihistoryDto.getLAT());
            ps.setDouble(2, wifihistoryDto.getLNT());

            affected = ps.executeUpdate();
            if (affected > 0) {
                System.out.println("히스토리 데이터 삽입 성공");
            } else {
                System.out.println("히스토리 데이터 삽입 실패");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(ps);
            close(c);
        }
        return affected;
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

            String sql = "DELETE FROM HISTORY WHERE ID = ?;";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, ID);

            affected = ps.executeUpdate();
            if (affected > 0) {
                System.out.println("히스토리 데이터 삭제 성공");
            } else {
                System.out.println("히스토리 데이터 삭제 실패");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(ps);
            close(conn);
        }
        return affected;
    }

    public int cnt() {
        int cnt = 0;

        try {
            Class.forName(DB.CLASS);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        Connection c = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            c = DriverManager.getConnection(DB.URL);

            String sql = "SELECT COUNT(*) FROM HISTORY;";

            ps = c.prepareStatement(sql);

            rs = ps.executeQuery();
            while (rs.next()) {
                cnt = rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            close(rs);
            close(ps);
            close(c);
        }
        return cnt;
    }

    public List<WIFI_HISTORYDTO> selectList() {
        List<WIFI_HISTORYDTO> historyDtoList = new ArrayList<>();

        try {
            Class.forName(DB.CLASS);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        Connection c = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            c = DriverManager.getConnection(DB.URL);

            String sql = "SELECT * FROM HISTORY ORDER BY ID DESC";

            ps = c.prepareStatement(sql);

            rs = ps.executeQuery();
            while (rs.next()) {
                int ID = rs.getInt("ID");
                double LAT = rs.getDouble("LAT");
                double LNT = rs.getDouble("LNT");
                Date SEARCH_DT = rs.getDate("SEARCH_DT");

                WIFI_HISTORYDTO wifihistoryDto = new WIFI_HISTORYDTO();
                wifihistoryDto.setID(ID);
                wifihistoryDto.setLAT(LAT);
                wifihistoryDto.setLNT(LNT);
                wifihistoryDto.setSEARCH_DT(SEARCH_DT);

                historyDtoList.add(wifihistoryDto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(ps);
            close(c);
        }
        return historyDtoList;
    }
}