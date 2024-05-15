package com.rollthedice.backend.domain.news.mapper;

import com.rollthedice.backend.domain.news.dto.response.NewsDetailResponse;
import com.rollthedice.backend.domain.news.dto.response.NewsResponse;
import com.rollthedice.backend.domain.news.entity.News;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants.ComponentModel;

@Mapper(componentModel = ComponentModel.SPRING)
public interface NewsMapper {

    NewsResponse toResponse(final News news, boolean isBookmarked);

    NewsDetailResponse toDetailResponse(final News news);
}
