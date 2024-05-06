package com.rollthedice.backend.domain.debate.service;

import com.rollthedice.backend.global.error.ErrorCode;
import com.rollthedice.backend.global.error.exception.ExternalApiException;
import net.minidev.json.JSONObject;
import org.apache.tomcat.util.json.JSONParser;
import org.apache.tomcat.util.json.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatusCode;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.LinkedHashMap;

@Service
public class ClovaSummary {
    private static final String KOREAN = "ko";
    private static final int POLITE_TONE = 2;
    private static final int SUMMARY_COUNT = 4;

    private static final String API_URL = "https://naveropenapi.apigw.ntruss.com/text-summary/v1/summarize";


    @Value("${clova.secret-key}")
    private String SECRET;

    @Value("${clova.client-id")
    private String CLIENT_ID;
    
    public String summaryDebate(String messages) {
        try {
            URL url = new URL(API_URL);
            HttpURLConnection connection = createRequestHeader(url);
            createRequestBody(connection, messages);

            StringBuilder response = getResponse(connection);

            return parseResponse(response);
        } catch (Exception e) {
            throw new ExternalApiException(ErrorCode.CLOVA_API_ERROR);
        }
    }

    private HttpURLConnection createRequestHeader(URL url) throws IOException {
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json;");
        connection.setRequestProperty("X-NCP-APIGW-API-KEY-ID", CLIENT_ID);
        connection.setRequestProperty("X-NCP-APIGW-API-KEY", SECRET);
        return connection;
    }

    private void createRequestBody(HttpURLConnection connection, String content) throws IOException {
        JSONObject document = new JSONObject();
        document.put("content", content);

        JSONObject option = new JSONObject();
        option.put("language", KOREAN);
        option.put("tone", POLITE_TONE);
        option.put("summaryCount", SUMMARY_COUNT);

        JSONObject requestObject = new JSONObject();
        requestObject.put("document", document);
        requestObject.put("option", option);

        connection.connect();
        DataOutputStream outputStream = new DataOutputStream(connection.getOutputStream());
        outputStream.write(requestObject.toString().getBytes(StandardCharsets.UTF_8));
        outputStream.flush();
        outputStream.close();
    }


    private StringBuilder getResponse(HttpURLConnection connection) throws IOException {
        BufferedReader reader = checkResponse(connection);
        String line;
        StringBuilder response = new StringBuilder();
        while ((line = reader.readLine()) != null) {
            response.append(line);
        }
        reader.close();
        return response;
    }

    private BufferedReader checkResponse(HttpURLConnection connection) throws IOException {
        int responseCode = connection.getResponseCode();

        return getResponseResult(connection, responseCode);
    }

    private BufferedReader getResponseResult(HttpURLConnection connection, int responseCode) throws IOException {
        if (HttpStatusCode.valueOf(responseCode).is2xxSuccessful()) {
            return new BufferedReader(new InputStreamReader(connection.getInputStream()));
        }
        return new BufferedReader(new InputStreamReader(connection.getErrorStream()));
    }


    private String parseResponse(StringBuilder response) throws ParseException {
        JSONParser parser = new JSONParser(response.toString());
        LinkedHashMap<String, String> hashMap = (LinkedHashMap<String, String>) parser.parse();
        JSONObject parsed = new JSONObject(hashMap);
        String summary = parsed.get("summary").toString();

    }
}
