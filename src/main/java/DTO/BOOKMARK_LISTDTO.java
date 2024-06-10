package DTO;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class BOOKMARK_LISTDTO {
    private int ID;             // 번호
    private int GROUP_ID;            // 북마크 그룹 번호
    private String MGR_NO;       // 와이파이 관리 번호
    private Date REGISTER_DT;       // 등록일자
}