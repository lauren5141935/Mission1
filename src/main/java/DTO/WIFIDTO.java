package DTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WIFIDTO {
    private double dist;            // 거리
    private String MGR_NO;           // 관리번호
    private String wrdofc;          // 자치구
    private String mainNm;          // 와이파이명
    private String adres1;          // 도로명주소
    private String adres2;          // 상세주소
    private String instlFloor;      // 설치위치(층)
    private String instlTy;         // 설치유형
    private String instlMby;        // 설치기관
    private String svcSe;           // 서비스구분
    private String cmcwr;           // 망종류
    private int cnstcYear;          // 설치년도
    private String inoutDoor;       // 실내외구분
    private String remars3;         // wifi접속환경
    private double LNT;             // X좌표
    private double LAT;             // Y좌표
    private String workDttm;        // 작업일자
}