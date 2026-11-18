package com.bizmate.util;

import java.io.IOException;
import java.io.PushbackReader;
import java.util.ArrayList;
import java.util.List;

//CSV파일을 한 행씩 읽음
public class CsvReader {

    public static List<String> readRow(PushbackReader reader) throws IOException {

        List<String> row = new ArrayList<>();
        StringBuilder field = new StringBuilder();

        boolean insideQuotes = false;
        boolean quoteClosed = false;
        boolean hasContent = false;

        int value;

        while ((value = reader.read()) != -1) {
            hasContent = true;
            char character = (char) value;

            if (insideQuotes) {
                if (character == '"') {
                    int next = reader.read();

                    if (next == '"') {
                        field.append('"');
                    } else {
                        insideQuotes = false;
                        quoteClosed = true;

                        if (next != -1) {
                            reader.unread(next);
                        }
                    }
                } else {
                    field.append(character);
                }

                continue;
            }

            if (character == ',') {
                row.add(field.toString());
                field.setLength(0);
                quoteClosed = false;
                continue;
            }

            if (character == '\r' || character == '\n') {
                if (character == '\r') {
                    int next = reader.read();

                    if (next != '\n' && next != -1) {
                        reader.unread(next);
                    }
                }

                row.add(field.toString());
                return row;
            }

            if (quoteClosed) {
                throw new IOException("닫는 따옴표 뒤에 잘못된 문자가 있습니다.");
            }

            if (character == '"') {
                if (field.length() > 0) {
                    throw new IOException("따옴표는 항목의 시작에만 사용할 수 있습니다.");
                }
                insideQuotes = true;
            } else {
                field.append(character);
            }
        }

        if (insideQuotes) {
            throw new IOException("닫히지 않은 따옴표가 있습니다.");
        }

        if (!hasContent) {
            return null;
        }

        row.add(field.toString());
        return row;
    }
}