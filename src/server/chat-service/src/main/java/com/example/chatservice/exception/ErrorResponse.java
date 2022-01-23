package com.example.chatservice.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.io.Serializable;

@AllArgsConstructor
@Getter
public class ErrorResponse implements Serializable {

    private static final long serialVersionUID = 1234678977089006444L;

    private ErrorCode errorMsg;
    private String message;
}