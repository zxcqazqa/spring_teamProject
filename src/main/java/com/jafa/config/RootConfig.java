package com.jafa.config;

import java.io.IOException;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.jafa.domain.BoardVO;
import com.jafa.domain.CartVO;
import com.jafa.domain.HopeVO;
import com.jafa.domain.MemberDTO;
import com.jafa.domain.MemberVO;
import com.jafa.domain.Bookshop.BookCategory;
import com.jafa.domain.Bookshop.BookSubCategory;
import com.jafa.domain.Bookshop.BookVO;


@Configuration
@MapperScan("com.jafa.repository")
@PropertySource(value = "classpath:database/oracle.properties")
public class RootConfig {
	@Value("${db.driver}")
	private String driverClass;
	@Value("${db.url}")
	private String url;
	@Value("${db.username}")
	private String username;
	@Value("${db.password}")
	private String password;
	
	
	@Bean
	public DataSource dataSource() {
		DataSource dataSource = new DataSource();
		dataSource.setDriverClassName(driverClass);
		dataSource.setUrl(url);
		dataSource.setUsername(username);
		dataSource.setPassword(password);
		
		return dataSource;
	}
	
	@Bean
	public SqlSessionFactoryBean sqlSessionFactory() throws IOException {
		SqlSessionFactoryBean factory = new SqlSessionFactoryBean();
		 factory.setDataSource(dataSource());
		 factory.setMapperLocations(
				 new PathMatchingResourcePatternResolver()
				 .getResources("classpath:mappers/**/*Mapper.xml"));
		 factory.setTypeAliases(BoardVO.class, HopeVO.class, MemberVO.class,
				 BookVO.class,BookCategory.class,BookSubCategory.class,CartVO.class,MemberDTO.class);
		return factory;
	}
	@Bean
	public SqlSessionTemplate sqlSessionTemplate() throws Exception {
		return new SqlSessionTemplate(sqlSessionFactory().getObject());
	}
	//MessageSource 설정
	@Bean
	public MessageSource messageSource() {
		ReloadableResourceBundleMessageSource messageSource = 
				new ReloadableResourceBundleMessageSource();
		
		messageSource.setBasename("classpath:message/label");
		messageSource.setDefaultEncoding("utf-8");
		return messageSource;
		
	}
	@Bean
	public static PropertySourcesPlaceholderConfigurer placeholderConfigurer() {
		return new PropertySourcesPlaceholderConfigurer();
	}
	@Bean
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		multipartResolver.setDefaultEncoding("utf-8");
		multipartResolver.setMaxUploadSize(-1); // 제한없음
		return multipartResolver;
	}
}
