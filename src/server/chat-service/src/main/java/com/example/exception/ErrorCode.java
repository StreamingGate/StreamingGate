package com.example.exception;

import lombok.Getter;

@Getter
public enum ErrorCode {
    C001("요청 권한이 유효하지 않습니다.");

    private String message;

    ErrorCode (String message){
        this.message = message;
    }
}
