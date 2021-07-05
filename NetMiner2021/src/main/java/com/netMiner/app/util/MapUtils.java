package com.netMiner.app.util;

import java.util.Map;

public class MapUtils {
	
	public static boolean KeyIsEmpty(Map<String, ?> map, String key) {
	    Object value = map.get(key);
	    return value == null ? true : false;
	}
	
	public static String valueToStringOrEmpty(Map<String, ?> map, String key) {
	    Object value = map.get(key);
	    return value == null ? "" : value.toString();
	}

	public static <K, V> V getOrDefault(Map<K,V> map, K key, V defaultValue) {
	    return map.containsKey(key) ? map.get(key) : defaultValue;
	}

}
