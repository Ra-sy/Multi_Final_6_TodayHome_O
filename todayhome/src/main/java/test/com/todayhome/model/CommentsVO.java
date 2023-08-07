package test.com.todayhome.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;

@Getter
@Setter
@ToString
public class CommentsVO {

    private int num;
    private int brdNum;
    private int mbrNum;
    private String nickname;
    private String content;
    private Timestamp wdate;
    private int cnt;
    private String mbrImg;
}
