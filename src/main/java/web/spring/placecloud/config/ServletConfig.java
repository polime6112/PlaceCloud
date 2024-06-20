package web.spring.placecloud.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

// servlet-context.xml과 동일 
@Configuration // Spring Container에서 관리하는 설정 클래스
@EnableWebMvc // Spring MVC 기능 사용
@ComponentScan(basePackages = { "web.spring.placecloud" }) // component scan 설정
public class ServletConfig implements WebMvcConfigurer {

   // ViewResolver 설정 메서드
   @Override
   public void configureViewResolvers(ViewResolverRegistry registry) {
      // InternalResourceViewResolver 생성 및 설정
      InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
      viewResolver.setPrefix("/WEB-INF/views/");
      viewResolver.setSuffix(".jsp");
      registry.viewResolver(viewResolver);
   }
   
   // ResourceHandlers 설정 메서드
   @Override
   public void addResourceHandlers(ResourceHandlerRegistry registry) {
      // resources 디렉토리 설정
      registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
      
   // 파일 업로드 경로를 웹 경로로 매핑
      registry.addResourceHandler("/upload/placecloud/**")
              .addResourceLocations("file:///C:/upload/placecloud/");
   }
   
   // 파일을 저장할 경로 bean 생성
   @Bean
   public String uploadPath() {
      return "C:\\upload\\placecloud";
   }
   
   // MultipartResolver bean 생성
   @Bean
   public CommonsMultipartResolver multipartResolver() {
      CommonsMultipartResolver resolver = new CommonsMultipartResolver();

      // 클라이언트가 업로드하는 요청의 전체 크기 (bytes)
      resolver.setMaxUploadSize(31457280); // 10MB

      // 클라이언트가 업로드하는 각 파일의 최대 크기 (bytes)
      resolver.setMaxUploadSizePerFile(10485760); // 10MB

      return resolver;
   }
} // end ServletConfig