package com.rollthedice.backend.domain.crawling;

import com.rollthedice.backend.domain.news.dto.NewsUrlDto;
import com.rollthedice.backend.domain.news.entity.News;
import com.rollthedice.backend.domain.news.service.NewsCategory;
import com.rollthedice.backend.domain.news.service.NewsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.Objects;

@Slf4j
@Service
@RequiredArgsConstructor
public class NewsCrawlingService {
    private static final String MAIN_URL = "https://news.naver.com/section/";
    private static final String CRON = "0 0 6,12 * * *";
    private static final String ZONE = "Asia/Seoul";

    @Value("${crawling.quantity}")
    private int crawlingQuantity;

    private final NewsService newsService;

    @Transactional
    @Scheduled(cron = CRON, zone = ZONE)
    public void scrap() throws IOException {
        for (NewsCategory category : NewsCategory.values()) {
            String categoryUrl = MAIN_URL + category.getNum();
            String categoryName = category.getName();

            scrapCategoryNews(categoryUrl);
            for (final News news : newsService.getNotCrawled()) {
                Document doc = Jsoup.connect(news.getUrl()).get();
                String title = scrapTitle(doc);
                String content = scrapContent(doc);
                String postDate = scrapPostDate(doc);

                news.addNewsBody(title, content, categoryName, postDate);
            }
        }
        newsService.summarizeNewsContent();
    }

    private void scrapCategoryNews(String categoryUrl) throws IOException {
        Document doc = Jsoup.connect(categoryUrl).get();
        Elements newsList = doc.select(".sa_list").select("li");
        if (newsList.size() < crawlingQuantity) {
            scrapNewsUrl(newsList.size(), newsList);
            return;
        }
        scrapNewsUrl(crawlingQuantity, newsList);
    }

    private void scrapNewsUrl(int quantity, Elements newsList) {
        for (int i = 0; i < quantity; i++) {
            Element news = newsList.get(i);
            String thumbnailUrl = scrapThumbnailUrl(news);
            String url = Objects.requireNonNull(news.selectFirst(".sa_text_title")).attr("href");

            newsService.addNews(new NewsUrlDto(url, thumbnailUrl));
        }
    }

    private String scrapThumbnailUrl(final Element news) {
        try {
            Element thumbnailUrlElement = news.selectFirst(".sa_thumb_link img");
            return thumbnailUrlElement != null ? thumbnailUrlElement.attr("src") : null;
        } catch (NullPointerException e) {
            return null;
        }
    }

    @Transactional
    public void scrapNewsContentsAndUpdate(String categoryName, News news) throws IOException {
        Document doc = Jsoup.connect(news.getUrl()).get();

        String title = scrapTitle(doc);
        String content = scrapContent(doc);
        String postDate = scrapPostDate(doc);

        news.addNewsBody(title, content, categoryName, postDate);
    }

    private String scrapTitle(final Document doc) {
        Element titleElement = doc.selectFirst("#ct > div.media_end_head.go_trans > div.media_end_head_title > h2");
        if (titleElement == null) {
            titleElement = doc.selectFirst("#content > div.end_ct > div > h2");
        }
        if (titleElement != null) {
            return titleElement.text();
        }
        return null;
    }

    private String scrapContent(final Document doc) {
        Elements contentElements = doc.select("article#dic_area");
        if (contentElements.isEmpty()) {
            contentElements = doc.select("#articeBody");
        }
        return contentElements.outerHtml().replaceAll("\\<[^>]*>|\\n", "");
    }

    private String scrapPostDate(final Document doc) {
        Element dateElement = doc.selectFirst("div#ct> div.media_end_head.go_trans > div.media_end_head_info.nv_notrans > div.media_end_head_info_datestamp > div > span");
        if (dateElement != null) {
            return dateElement.attr("data-date-time");
        } else {
            Element altDateElement = doc.selectFirst("#content > div.end_ct > div > div.article_info > span > em");
            if (altDateElement != null) {
                return altDateElement.text();
            }
        }
        return null;
    }
}

