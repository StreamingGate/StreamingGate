package com.example.userservice.vo;

import lombok.Data;
import javax.validation.constraints.Email;
import javax.validation.constraints.Size;

@Data
public class RequestUser {
//    @Email
    private String email;
//    @Size(max = 30)
    private String name;
//    @Size(max = 8)
    private String nickName;
//    @Size(min = 6,max = 16 )
    private String password;
    private String profileImage;
}
