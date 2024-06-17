package com.rollthedice.backend.global.config;


import com.querydsl.jpa.impl.JPAQueryFactory;
import jakarta.persistence.EntityManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class QueryDslConfig {
    @Configuration
    public class QuerydslConfig {
        @Bean
        public JPAQueryFactory jpaQueryFactory(final EntityManager em) {
            return new JPAQueryFactory(em);
        }
    }
}