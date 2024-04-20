package com.rollthedice.backend.domain.bookmark.repository;

import com.rollthedice.backend.domain.member.entity.Member;
import com.rollthedice.backend.domain.bookmark.entity.Bookmark;
import com.rollthedice.backend.domain.news.entity.News;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookmarkRepository extends JpaRepository<Bookmark, Long> {
    Boolean existsBookmarkByMemberAndNews(Member member, News news);

    List<Bookmark> findAllByMemberOrderByCreatedAt(Member member, Pageable pageable);

    void deleteByNewsId(Long newsId);
}
