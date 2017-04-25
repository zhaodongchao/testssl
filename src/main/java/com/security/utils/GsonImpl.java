package com.security.utils;

import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;
import com.security.utils.annotation.NotToJson;

import java.io.IOException;

/**
 * Created by zhaodongchao on 2017/4/19.
 */
public class GsonImpl {
    private Gson g = new GsonBuilder()
            .setExclusionStrategies(new MyExclusionStrategy())
            .registerTypeAdapterFactory(new NullStringToEmptyAdapterFactory())
            .setDateFormat("yyyy-MM-dd")
            .disableHtmlEscaping()
            .create();

    public String toJson(Object o) {
        return g.toJson(o);
    }

    public <T> T fromJson(String json, Class<T> classOfT) {
        return g.fromJson(json, classOfT);
    }

    class NullStringToEmptyAdapterFactory<T> implements TypeAdapterFactory {
        public <T> TypeAdapter<T> create(Gson gson, TypeToken<T> type) {
            Class<T> rawType = (Class<T>) type.getRawType();
            if (rawType != String.class) {
                return null;
            }
            return (TypeAdapter<T>) new StringNullAdapter();
        }
    }

    class StringNullAdapter extends TypeAdapter<String> {
        @Override
        public String read(JsonReader reader) throws IOException {
            if (reader.peek() == JsonToken.NULL) {
                reader.nextNull();
                return "";
            }
            return reader.nextString();
        }

        @Override
        public void write(JsonWriter writer, String value) throws IOException {
            if (value == null) {
                writer.value("");
                return;
            }
            writer.value(value);
        }
    }

    /**
     * 排除策略,编写不当会造成性能问题
     * @author Administrator
     *
     */
    class MyExclusionStrategy implements ExclusionStrategy {

        public boolean shouldSkipClass(Class<?> arg0) {
            return false;
        }

        public boolean shouldSkipField(FieldAttributes fa) {
            return fa.getAnnotation(NotToJson.class) != null;
        }

    }
}
