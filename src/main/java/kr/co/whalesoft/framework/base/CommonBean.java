package kr.co.whalesoft.framework.base;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Objects;
import java.util.Set;
import kr.co.whalesoft.framework.utils.PagingUtilsFromMap;
import org.apache.commons.lang3.ArrayUtils;

public class CommonBean extends PagingUtilsFromMap {

    private static final String ARRAY_DELIMITER = ",";
    private static final String NULL_DEFAULT = "";

    public static <K, V> Map<K, V> of(K key, V value) {
        Map<K, V> map = new HashMap<>();
        map.put(key, value);
        return map;
    }

    public static <K, V> Map<K, V> of(K key1, V value1, K key2, V value2) {
        Map<K, V> map = of(key1, value1);
        map.put(key2, value2);
        return map;
    }

    public static <K, V> Map<K, V> of(K key1, V value1, K key2, V value2, K key3, V value3) {
        Map<K, V> map = of(key1, value1, key2, value2);
        map.put(key3, value3);
        return map;
    }

    public static <K, V> Map<K, V> of(K key1, V value1, K key2, V value2, K key3, V value3, K key4, V value4) {
        Map<K, V> map = of(key1, value1, key2, value2, key3, value3);
        map.put(key4, value4);
        return map;
    }

    public static <K, V> Map<K, V> of(K key1, V value1, K key2, V value2, K key3, V value3, K key4, V value4, K key5, V value5) {
        Map<K, V> map = of(key1, value1, key2, value2, key3, value3, key4, value4);
        map.put(key5, value5);
        return map;
    }

    public Object get(String key) {
        return map.get(key);
    }

    public String asString(String key) {
        return asString(key, NULL_DEFAULT);
    }

    public String asString(String key, String defaultValue) {
        return Objects.toString(map.get(key), defaultValue);
    }

    // HttpServletRequest.getParameterValues 대체 ( ,로 구분 )
    public String getArrToStr(String key) {
        Object objectType = get(key);
        if (objectType == null) {
            return null;
        }
        return getArrToStr(objectType);
    }

    private String getArrToStr(final Object objectType) {
        if (isNotStringType(objectType)) {
            return null;
        }
        return getArrToStrInternal(objectType);
    }

    private boolean isNotStringType(final Object objectType) {
        return !(objectType instanceof String) && !(objectType instanceof String[]);
    }

    private String getArrToStrInternal(final Object objectType) {
        if (objectType instanceof String) {
            return getArrToStrInternal(new String[]{(String) objectType});
        }
        return getArrToStrInternal((String[]) objectType);
    }

    private String getArrToStrInternal(final String[] strArr) {
        if (ArrayUtils.isEmpty(strArr)) {
            return null;
        }
        return String.join(ARRAY_DELIMITER, strArr);
    }

    public void put(String key, Object value) {
        map.put(key, value);
    }

    public Object remove(String key) {
        return map.remove(key);
    }

    public boolean containsKey(String key) {
        return map.containsKey(key);
    }

    public boolean containsValue(Object value) {
        return map.containsValue(value);
    }

    public void clear() {
        map.clear();
    }

    public Set<Entry<String, Object>> entrySet() {
        return map.entrySet();
    }

    public Set<String> keySet() {
        return map.keySet();
    }

    public boolean isEmpty() {
        return map.isEmpty();
    }

    public void putAll(Map<? extends String, ?> m) {
        map.putAll(m);
    }

    public void putIfAbsent(String key, Object value) {
        map.putIfAbsent(key, value);
    }

    public Map<String, Object> getMap() {
        return map;
    }

    public void setAdd_id(String sessionMemberId) {
        map.put("add_id", sessionMemberId);
    }

    public void setModify_id(String sessionMemberId) {
        map.put("modify_id", sessionMemberId);
    }
}
