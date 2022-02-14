package com.example.chatservice.redis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.PostConstruct;
import com.example.chatservice.exception.CustomChatException;
import com.example.chatservice.exception.ErrorCode;
import com.example.chatservice.dto.chat.ChatConsume;
import com.example.chatservice.dto.chat.ChatProduce;
import com.example.chatservice.dto.chat.SenderRole;
import com.example.chatservice.dto.room.Room;
import com.example.chatservice.utils.RedisMessaging;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class RedisRoomService {

    private static final String CHAT_ROOMS = "CHAT_ROOM";
    private final RedisMessageListenerContainer redisMessageListener;
    private final RedisSubscriber redisSubscriber;
    private HashOperations<String, String, Room> opsHashRoom; // 방 관리에 사용하는 Redis 연산자
    private Map<String, ChannelTopic> topics; // 서버별로 roomId에 매치되는 topic정보를 넣는다.

    @PostConstruct
    private void init() {
        opsHashRoom = RedisMessaging.getOpsHashRoom();
        topics = new HashMap<>();
    }

    public List<Room> findAll() {
        return opsHashRoom.values(CHAT_ROOMS);
    }

    public Room findById(String roomUuid) {
        return opsHashRoom.get(CHAT_ROOMS, roomUuid);
    }

    public Room create(String roomUuid, String hostUuid) {
        Room room = new Room(roomUuid, hostUuid);
        opsHashRoom.put(CHAT_ROOMS, room.getUuid(), room);
        return room;
    }

    public void addPinnedChat(String roomUuid, ChatProduce pinnedChat) throws CustomChatException {
        if (!pinnedChat.getSenderRole().equals(SenderRole.STREAMER))
            throw new CustomChatException(ErrorCode.C001, roomUuid);

        Room room = opsHashRoom.get(CHAT_ROOMS, roomUuid);
        room.updatePinnedChat(new ChatConsume(pinnedChat));
        opsHashRoom.put(CHAT_ROOMS, room.getUuid(), room); // update
    }

    /* 채팅방 입장(접속자 수 증가) */
    public int enter(String roomUuid, String userUuid) {
        ChannelTopic channelTopic = getOrAddTopic(roomUuid);
        Room room = opsHashRoom.get(CHAT_ROOMS, roomUuid);

        int userCnt = room.addUser(userUuid);
        log.info("add user:" + room.getUuid() + " " + userCnt + "명");
        opsHashRoom.put(CHAT_ROOMS, room.getUuid(), room);

        RedisMessaging.publish(channelTopic, new ChatProduce(roomUuid, userCnt));
        return userCnt;
    }

    /* 채팅방 퇴장(접속자 수 감소) */
    public int exit(String roomUuid, String userUuid) throws IllegalArgumentException {
        ChannelTopic channelTopic = getOrAddTopic(roomUuid);
        Room room = opsHashRoom.get(CHAT_ROOMS, roomUuid);

        int userCnt = room.removeUser(userUuid);
        log.info("add user:" + room.getUuid() + " " + userCnt + "명");
        opsHashRoom.put(CHAT_ROOMS, room.getUuid(), room);

        RedisMessaging.publish(channelTopic, new ChatProduce(roomUuid, userCnt));
        return userCnt;
    }

    /* 채팅방 삭제 */
    public String removeRoom(String roomUuid){
        ChannelTopic channelTopic = topics.get(roomUuid);
        if (channelTopic != null) {
            topics.remove(roomUuid);
        }
        opsHashRoom.delete(CHAT_ROOMS, roomUuid);
        return roomUuid;
    }

    public ChannelTopic getOrAddTopic(String roomUuid) {
        ChannelTopic channelTopic = topics.get(roomUuid);
        if (channelTopic == null) {
            channelTopic = new ChannelTopic(roomUuid);
            redisMessageListener.addMessageListener(redisSubscriber, channelTopic);
            topics.put(roomUuid, channelTopic);
        }
        return channelTopic;
    }
}