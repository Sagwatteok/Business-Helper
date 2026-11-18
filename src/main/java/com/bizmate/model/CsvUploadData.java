package com.bizmate.model;

import java.util.List;

public class CsvUploadData {

    private String fileName;
    private List<String> headers;
    private List<List<String>> rows;

    public CsvUploadData(String fileName, List<String> headers,
                         List<List<String>> rows) {
        this.fileName = fileName;
        this.headers = headers;
        this.rows = rows;
    }

    public String getFileName() {
        return fileName;
    }

    public List<String> getHeaders() {
        return headers;
    }

    public List<List<String>> getRows() {
        return rows;
    }

    public int getRowCount() {
        return rows.size();
    }
}