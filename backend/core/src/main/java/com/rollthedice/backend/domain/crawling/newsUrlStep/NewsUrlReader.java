package com.rollthedice.backend.domain.crawling.newsUrlStep;

import com.rollthedice.backend.domain.news.entity.NewsCategory;
import org.springframework.batch.item.ItemReader;

public class NewsUrlReader implements ItemReader<String> {
    private static final String MAIN_URL = "https://news.naver.com/section/";

    private int categoryIndex;
    private final NewsCategory[] categories;

    public NewsUrlReader() {
        this.categoryIndex = 0;
        this.categories = NewsCategory.values();
    }

    @Override
    public String read() {
        if (categoryIndex < NewsCategory.values().length) {
            int categoryNum = categories[categoryIndex++].getNum();
             return MAIN_URL + categoryNum;
        } else {
            return null;
        }
    }
}
