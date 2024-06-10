package DTO;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class WIFI_HISTORYDTO {
    private int ID;         // 번호
    private double LNT;     // X좌표
    private double LAT;     // Y좌표
    private Date SEARCH_DT;   // 조회일자
}