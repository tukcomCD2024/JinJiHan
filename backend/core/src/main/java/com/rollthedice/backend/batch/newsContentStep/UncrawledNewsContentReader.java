package com.rollthedice.backend.batch.newsContentStep;

import com.rollthedice.backend.domain.news.entity.News;
import com.rollthedice.backend.domain.news.repository.NewsRepository;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.batch.item.ItemReader;

import java.io.IOException;
import java.util.Iterator;

public class UncrawledNewsContentReader implements ItemReader<PreSummarizedNewsDto> {
    private final NewsRepository newsRepository;
    private Iterator<News> uncrawledNewsContents;

    public UncrawledNewsContentReader(NewsRepository newsRepository) {
        this.newsRepository = newsRepository;
        uncrawledNewsContents = newsRepository.findAllByContentIsNull().iterator();
    }

    @Override
    public PreSummarizedNewsDto read() throws IOException {
        if (!hasNextUncrawledNews()) {
            return null;
        }
        News news = uncrawledNewsContents.next();
        Document doc = Jsoup.connect(news.getUrl()).get();
        return getNewsContent(news, doc);
    }

    private boolean hasNextUncrawledNews() {
        if (!uncrawledNewsContents.hasNext()) {
            uncrawledNewsContents = newsRepository.findAllByContentIsNull().iterator();
        }
        return uncrawledNewsContents.hasNext();
    }

    private PreSummarizedNewsDto getNewsContent(News news, Document doc) {
        return PreSummarizedNewsDto.builder()
                .id(news.getId())
                .title(scrapTitle(doc))
                .content(scrapContent(doc))
                .postDate(scrapPostDate(doc))
                .build();
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
