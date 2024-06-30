package com.rollthedice.backend.domain.readNews.api;

import com.rollthedice.backend.domain.readNews.service.ReadNewsService;
import com.rollthedice.backend.global.BaseControllerTest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.ResultActions;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@DisplayName("ReadNewsController의 ")
@WebMvcTest(ReadNewsController.class)
class ReadNewsControllerTest extends BaseControllerTest {
    @MockBean
    private ReadNewsService readNewsService;

    @Test
    @DisplayName("조회한 News 전체 조회 API가 수행되는가")
    void getReadNews() throws Exception{
        //when
        final ResultActions perform = mockMvc.perform(
                get("/read-news/viewed-history")
                        .contentType(MediaType.APPLICATION_JSON)
                        .header("Authorization", "Bearer " + accessToken)
        ).andDo(print());

        //then
        perform.andExpect(status().isOk());
    }
}
