package com.bizmate.model;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class ExpenseCsvDraft {

    private final String token;
    private final CsvUploadData uploadData;
    private final Map<String, Integer> mapping;

    public ExpenseCsvDraft(CsvUploadData uploadData, Map<String, Integer> mapping) {
        this.token = UUID.randomUUID().toString();
        this.uploadData = uploadData;
        this.mapping = Collections.unmodifiableMap(new HashMap<>(mapping));
    }

    public String getToken() {
        return token;
    }

    public CsvUploadData getUploadData() {
        return uploadData;
    }

    public Map<String, Integer> getMapping() {
        return mapping;
    }
}