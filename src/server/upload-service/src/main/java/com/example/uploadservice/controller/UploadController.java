package com.example.uploadservice.controller;

import com.example.uploadservice.dto.UploadRequestDto;
import com.example.uploadservice.dto.UploadResponseDto;
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

@Slf4j
@RequiredArgsConstructor
@RestController
public class UploadController {

    private final VideoService videoService;
    private final UploadService uploadService;
    private final TranscodeService transcodeService;

    /**
     * <pre>
     * pipeline
     * 1. upload video to S3
     *      folder: pk
     *      m3u8: pk.m3u8
     *      ts:
     *      thumbnail: thumbnail.jpg
     * 2. transcode video (S3) from mp4 to m3u8
     * 3. save to mariadb video table
     * 4. notification
     * </pre>
     */
    @PostMapping(value = "/upload", consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseEntity<String> video(@RequestPart(value = "video") MultipartFile multipartFileVideo,
                                        @RequestPart(value = "thumbnail", required = false) MultipartFile multipartFileThumbnail,
                                        @RequestPart(value = "data") UploadRequestDto dto) {
        log.info("multipartFile come....");

        /* TODO VideoService*/
        Long videoId = videoService.add(dto);
        String inputSavedDir = uploadService.uploadRawFile(videoId, multipartFileVideo, multipartFileThumbnail);
        UploadResponseDto uploadResponseDto = transcodeService.convertMp4ToTs(inputSavedDir);
        String result = uploadService.uploadTranscodedFile(uploadResponseDto);

        return ResponseEntity.ok(result);
    }
}
