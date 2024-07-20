package com.rollthedice.backend.batch.newsUrlStep;

import com.rollthedice.backend.domain.news.entity.NewsCategory;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.batch.item.ItemReader;
import org.springframework.beans.factory.annotation.Value;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

public class NewsUrlReader implements ItemReader<InitNewsDto> {
    @Value("${crawling.quantity}")
    private int crawlingQuantity;

    private final Iterator<NewsCategory> categories;
    private final Queue<InitNewsDto> initNews = new LinkedList<>();

    public NewsUrlReader() {
        categories = Arrays.stream(NewsCategory.values()).collect(Collectors.toList()).iterator();
    }

    @Override
    public InitNewsDto read() throws IOException {
        while (initNews.isEmpty() && categories.hasNext()) {
            NewsCategory category = categories.next();
            initNews.addAll(scrapCategoryNews(category));
        }
        return initNews.poll();
    }

    private List<InitNewsDto> scrapCategoryNews(NewsCategory category) throws IOException {
        Document doc = Jsoup.connect(category.getCategoryUrl()).get();
        Elements newsList = doc.select(".sa_list").select("li");
        if (newsList.size() < crawlingQuantity) {
            return scrapNewsUrl(newsList.size(), newsList, category);
        }
        return scrapNewsUrl(crawlingQuantity, newsList, category);
    }

    private List<InitNewsDto> scrapNewsUrl(int quantity, Elements newsList, NewsCategory category) {
        List<InitNewsDto> urls = new ArrayList<>();
        for (int i = 0; i < quantity; i++) {
            Element news = newsList.get(i);
            String url = Objects.requireNonNull(news.selectFirst(".sa_text_title")).attr("href");
            urls.add(new InitNewsDto(category.getName(), url));
        }
        return urls;
    }
}
