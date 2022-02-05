package com.example.uploadservice.controller;

import com.example.uploadservice.dto.UploadRequestDto;
import com.example.uploadservice.dto.VideoDto;
import com.example.uploadservice.exceptionHandler.customexception.CustomUploadException;
import com.example.uploadservice.service.TranscodeService;
import com.example.uploadservice.service.UploadService;
import com.example.uploadservice.service.VideoService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@RestController
public class UploadController {

    private final VideoService videoService;
    private final UploadService uploadService;
    private final TranscodeService transcodeService;

    @PostMapping(value = "/upload", consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseEntity<Map<String, String>> video(@RequestPart(value = "video") MultipartFile multipartFileVideo,
                                        @RequestPart(value = "thumbnail", required = false) MultipartFile multipartFileThumbnail,
                                        @RequestPart(value = "data") UploadRequestDto dto) throws CustomUploadException  {
        VideoDto videoDto = new VideoDto(dto);
        String videoUuid = uploadService.uploadRawFile(multipartFileVideo, multipartFileThumbnail, videoDto);
        transcodeService.convertMp4ToTs(videoUuid, multipartFileThumbnail);
        String s3OutputPath = uploadService.uploadTranscodedFile(videoUuid);
        videoDto.updateMetaData(s3OutputPath);
        videoService.add(videoDto);

        return ResponseEntity.ok(Map.of("result", "success"));
    }
}