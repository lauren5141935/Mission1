package DAO;

import wifi.DB;
import wifi.JDBCT;
import DTO.WIFIDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WIFIDAO extends JDBCT {
    public int insert(WIFIDTO wifiDto) {
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

            String sql = "INSERT INTO WIFI VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

            ps = c.prepareStatement(sql);
            ps.setString(1, wifiDto.getMGR_NO());
            ps.setString(2, wifiDto.getWrdofc());
            ps.setString(3, wifiDto.getMainNm());
            ps.setString(4, wifiDto.getAdres1());
            ps.setString(5, wifiDto.getAdres2());
            ps.setString(6, wifiDto.getInstlFloor());
            ps.setString(7, wifiDto.getInstlTy());
            ps.setString(8, wifiDto.getInstlMby());
            ps.setString(9, wifiDto.getSvcSe());
            ps.setString(10, wifiDto.getCmcwr());
            ps.setInt(11, wifiDto.getCnstcYear());
            ps.setString(12, wifiDto.getInoutDoor());
            ps.setString(13, wifiDto.getRemars3());
            ps.setDouble(14, wifiDto.getLAT());
            ps.setDouble(15, wifiDto.getLNT());
            ps.setString(16, wifiDto.getWorkDttm());

            affected = ps.executeUpdate();
            if (affected > 0) {
                System.out.println("와이파이 데이터 삽입 성공");
            } else {
                System.out.println("와이파이 데이터 삽입 실패");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(ps);
            close(c);
        }
        return affected;
    }

    public WIFIDTO select(String MGR_NO) {
        WIFIDTO wifiDto = new WIFIDTO();

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

            String sql = "SELECT * FROM WIFI WHERE X_SWIFI_MGR_NO = ?;";

            ps = c.prepareStatement(sql);
            ps.setString(1, MGR_NO);

            rs = ps.executeQuery();
            while (rs.next()) {
                String MGR_NO1 = rs.getString("X_SWIFI_MGR_NO");
                String wrdofc = rs.getString("X_SWIFI_WRDOFC");
                String mainNm = rs.getString("X_SWIFI_MAIN_NM");
                String adres1 = rs.getString("X_SWIFI_ADRES1");
                String adres2 = rs.getString("X_SWIFI_ADRES2");
                String instlFloor = rs.getString("X_SWIFI_INSTL_FLOOR");
                String instlTy = rs.getString("X_SWIFI_INSTL_TY");
                String instlMby = rs.getString("X_SWIFI_INSTL_MBY");
                String svcSe = rs.getString("X_SWIFI_SVC_SE");
                String cmcwr = rs.getString("X_SWIFI_CMCWR");
                int cnstcYear = rs.getInt("X_SWIFI_CNSTC_YEAR");
                String inoutDoor = rs.getString("X_SWIFI_INOUT_DOOR");
                String remars3 = rs.getString("X_SWIFI_REMARS3");
                double LAT = rs.getDouble("LAT");
                double LNT = rs.getDouble("LNT");
                String workDttm = rs.getString("WORK_DTTM");

                wifiDto.setMGR_NO(MGR_NO1);
                wifiDto.setWrdofc(wrdofc);
                wifiDto.setMainNm(mainNm);
                wifiDto.setAdres1(adres1);
                wifiDto.setAdres2(adres2);
                wifiDto.setInstlFloor(instlFloor);
                wifiDto.setInstlTy(instlTy);
                wifiDto.setInstlMby(instlMby);
                wifiDto.setSvcSe(svcSe);
                wifiDto.setCmcwr(cmcwr);
                wifiDto.setCnstcYear(cnstcYear);
                wifiDto.setInoutDoor(inoutDoor);
                wifiDto.setRemars3(remars3);
                wifiDto.setLAT(LAT);
                wifiDto.setLNT(LNT);
                wifiDto.setWorkDttm(workDttm);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(ps);
            close(c);
        }
        return wifiDto;
    }

    public void deleteAll() {
        try {
            Class.forName(DB.CLASS);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection c = null;
        PreparedStatement ps = null;

        try {
            c = DriverManager.getConnection(DB.URL);

            String sql = "DELETE FROM WIFI";
            ps = c.prepareStatement(sql);

            int affected = ps.executeUpdate();
            if (affected > 0) {
                System.out.println("모든 와이파이 데이터 제거 성공");
            } else {
                System.out.println("모든 와이파이 데이터 제거 실패");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(ps);
            close(c);
        }
    }

    public List<WIFIDTO> selectList(Double LAT, Double LNT) {
        List<WIFIDTO> wifiDtoList = new ArrayList<>();

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

            String sql = "SELECT *, " +
                    "round(6371*acos(cos(radians(?))*cos(radians(LAT))*cos(radians(LNT)" +
                    "-radians(?))+sin(radians(?))*sin(radians(LAT))), 4) " +
                    "AS DISTANCE " +
                    "FROM WIFI " +
                    "ORDER BY DISTANCE " +
                    "LIMIT 20;";

            ps = c.prepareStatement(sql);
            ps.setDouble(1, LAT);
            ps.setDouble(2, LNT);
            ps.setDouble(3, LAT);

            rs = ps.executeQuery();
            while (rs.next()) {
                double dist = rs.getDouble("DISTANCE");
                String MGR_NO2 = rs.getString("X_SWIFI_MGR_NO");
                String wrdofc = rs.getString("X_SWIFI_WRDOFC");
                String mainNm = rs.getString("X_SWIFI_MAIN_NM");
                String adres1 = rs.getString("X_SWIFI_ADRES1");
                String adres2 = rs.getString("X_SWIFI_ADRES2");
                String instlFloor = rs.getString("X_SWIFI_INSTL_FLOOR");
                String instlTy = rs.getString("X_SWIFI_INSTL_TY");
                String instlMby = rs.getString("X_SWIFI_INSTL_MBY");
                String svcSe = rs.getString("X_SWIFI_SVC_SE");
                String cmcwr = rs.getString("X_SWIFI_CMCWR");
                int cnstcYear = rs.getInt("X_SWIFI_CNSTC_YEAR");
                String inoutDoor = rs.getString("X_SWIFI_INOUT_DOOR");
                String remars3 = rs.getString("X_SWIFI_REMARS3");
                double LAT2 = rs.getDouble("LAT");
                double LNT2 = rs.getDouble("LNT");
                String workDttm = rs.getString("WORK_DTTM");

                WIFIDTO wifiDto = new WIFIDTO();
                wifiDto.setDist(dist);
                wifiDto.setMGR_NO(MGR_NO2);
                wifiDto.setWrdofc(wrdofc);
                wifiDto.setMainNm(mainNm);
                wifiDto.setAdres1(adres1);
                wifiDto.setAdres2(adres2);
                wifiDto.setInstlFloor(instlFloor);
                wifiDto.setInstlTy(instlTy);
                wifiDto.setInstlMby(instlMby);
                wifiDto.setSvcSe(svcSe);
                wifiDto.setCmcwr(cmcwr);
                wifiDto.setCnstcYear(cnstcYear);
                wifiDto.setInoutDoor(inoutDoor);
                wifiDto.setRemars3(remars3);
                wifiDto.setLAT(LAT2);
                wifiDto.setLNT(LNT2);
                wifiDto.setWorkDttm(workDttm);

                wifiDtoList.add(wifiDto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(ps);
            close(c);
        }
        return wifiDtoList;
    }
}