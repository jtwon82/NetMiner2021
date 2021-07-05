package com.netMiner.app.util;

import java.util.List;

import org.springframework.util.CollectionUtils;

public class PagedList<T> {
	
	private int totalEntryCount;
    private Paging paging;
    private List<T> list;

    public boolean isEmpty() {
        if (CollectionUtils.isEmpty(list)) {
            return true;
        }
        return false;
    }
    
    public boolean isNotEmpty(){
        return !isEmpty();
    }

    public int getTotalEntryCount() {
        return totalEntryCount;
    }

    public void setTotalEntryCount(int totalEntryCount) {
        this.totalEntryCount = totalEntryCount;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public Paging getPaging() {
        if (paging != null) {
            paging.setTotalEntryCount(totalEntryCount);
        }
        return paging;
    }

    public void setPaging(Paging paging) {
        this.paging = paging;
    }
}
