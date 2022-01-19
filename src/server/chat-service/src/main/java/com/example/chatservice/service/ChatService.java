package com.example.chatservice.service;

import java.util.List;

import com.example.chatservice.dto.ChatDto;
import com.example.chatservice.entity.chat.Chat;
import com.example.chatservice.entity.chat.ChatRepository;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class ChatService {

    private final ChatRepository chatRepository;
    
    public void create(ChatDto chatDto){
        chatRepository.save(chatDto.toEntity()); // TODO: mapper로 바꾸기
    }
    
    public List<Chat> findByRoomId(String roomId) {
        return chatRepository.findAllByRoomId(roomId);
    }

    public List<Chat> findAll() {
        return chatRepository.findAll();
    }

}
