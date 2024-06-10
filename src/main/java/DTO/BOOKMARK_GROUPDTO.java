package DTO;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;
@Getter
@Setter
public class BOOKMARK_GROUPDTO {
    private int ID;             // 번호
    private String NAME;        // 그룹명
    private int SEQUENCE;            // 순서
    private Date REGISTER_DT;       // 등록일자
    private Date UPDATE_DT;       // 갱신 일자
}

