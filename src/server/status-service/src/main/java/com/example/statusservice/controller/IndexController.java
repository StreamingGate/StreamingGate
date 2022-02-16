package com.example.statusservice.controller;


import com.example.statusservice.dto.PartnerDto;
import com.example.statusservice.dto.UserDto;
import com.example.statusservice.redis.RedisUserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Controller
public class IndexController {

    private static final String RESPONSE_MAP_KEY = "result";
    private static final String RESPONSE_SUCCESS = "success";
    private final RedisUserService redisUserService;

    @GetMapping("/home")
    public String home(){
        return "home";
    }

    @ResponseBody
    @GetMapping("/init-redis")
    public String initRedis(){
        redisUserService.initRedis();
        redisUserService.addTopics();
        return "";
    }

    @ResponseBody
    @GetMapping("/list")
    public ResponseEntity<Map<String,List<UserDto>>> getFriendsStatus(@RequestParam("uuid")String uuid){
        log.info("list uuid:"+uuid);
        List<UserDto> result = redisUserService.findAll(uuid);
        return ResponseEntity.ok(Map.of("result", result));
    }

    @ResponseBody
    @PostMapping("/friend")
    public ResponseEntity<Map<String,String>> addFriend(@RequestBody PartnerDto dto) throws Exception {
        log.info("addFriend....");
        redisUserService.addFriend(dto.getRequestDto(), dto.getSenderOrTargetDto());
        redisUserService.addFriend(dto.getSenderOrTargetDto(), dto.getRequestDto());
        return ResponseEntity.ok(Map.of(RESPONSE_MAP_KEY, RESPONSE_SUCCESS));
    }

    @DeleteMapping("/friend")
    public ResponseEntity<Map<String,String>> deleteFriend(@RequestBody PartnerDto dto) throws Exception {
        log.info("deleteFriend api....");
        redisUserService.deleteFriend(dto.getRequestDto(), dto.getSenderOrTargetDto());
        redisUserService.deleteFriend(dto.getSenderOrTargetDto(), dto.getRequestDto());
        return ResponseEntity.ok(Map.of(RESPONSE_MAP_KEY, RESPONSE_SUCCESS));
    }

    /* 유저 탈퇴 api 생성 시 사용 */
    @DeleteMapping("/user")
    public ResponseEntity<Map<String,String>> deleteUser(@RequestParam("uuid") String uuid) throws Exception {
        log.info("deleteUser api....");
        redisUserService.deleteUser(uuid);
        return ResponseEntity.ok(Map.of(RESPONSE_MAP_KEY, RESPONSE_SUCCESS));
    }
}
