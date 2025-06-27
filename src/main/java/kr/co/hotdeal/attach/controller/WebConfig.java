package kr.co.hotdeal.attach.controller;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    // application.properties 등에서 파일 경로를 주입받을 수 있습니다.
    // @Value("${upload.path}")
    // private String uploadPath;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/upload/**") // 1. 웹 브라우저에 노출할 URL 경로
                .addResourceLocations("file:///c:/upload/"); // 2. 실제 파일이 저장된 물리적 경로
    }
}