package com.example.mainservice.entity.Video;

import com.example.mainservice.entity.Category;
import com.example.mainservice.entity.Metadata.Metadata;
import com.example.mainservice.entity.User.UserEntity;
import com.example.mainservice.entity.ViewdHistory.ViewedHistory;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@NoArgsConstructor
@Getter
@Entity
public class Video {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 100)
    private String title;

    private String uploaderNickname;

    @Column(length = 5000)
    private String content;

    private int likeCnt;

    @Enumerated(EnumType.STRING)
    @Column(length = 10)
    private Category category;

    @Column(columnDefinition="TEXT")
    private String thumbnail;
    
    private int hits;

    private short reportCnt;

    private LocalDateTime createdAt;

    @ManyToOne
    @JoinColumn(name = "users_id")
    private UserEntity userEntity;

    @OneToMany( mappedBy = "video")
    private List<ViewedHistory> viewedHistories;

    @OneToOne
    @JoinColumn(name = "metadata_id")
    private Metadata metadata;

    public Video(String title) {
        this.title = title;
    }

    public void addReportCnt(int reportCnt){
        if(reportCnt != 1 && reportCnt != -1) log.error("잘못된 신고 수가 업데이트됩니다. parameter:"+reportCnt);
        this.reportCnt+=reportCnt;
        if(this.reportCnt<0) this.reportCnt = 0;
    }

    public void addLikeCnt(int likeCnt){
        if(likeCnt != 1 && likeCnt != -1) log.error("잘못된 좋아요 수가 업데이트됩니다. parameter:"+likeCnt);
        this.likeCnt+=likeCnt;
        if(this.likeCnt<0) this.likeCnt = 0;
    }

}