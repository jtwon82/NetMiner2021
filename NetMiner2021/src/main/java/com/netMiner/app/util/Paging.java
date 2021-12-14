package com.netMiner.app.util;

import java.util.HashMap;
import java.util.Iterator;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;

@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
public class Paging {
	private int pageNumber; // 조회하고자하는 페이지 번호
	private int totalEntryCount; // 페이징 대상의 전체 갯수
	private int entryCountPerOnePage; // 한페이지에 보여질 아이템 갯수
	private int pageCountPerPageGroup; // 페이징 부분에서 보여질 페이지의 갯수
	private String baseUrlFormat; // 페이징을 통한 페이지 이동 할 수 있는 url format

//	@Override
//	public String toString() {
//		return ToStringBuilder.reflectionToString(this);
//	}

	public int getTotalEntryCount() {
		return totalEntryCount;
	}

	public void setTotalEntryCount(int totalEntryCount) {
		this.totalEntryCount = totalEntryCount;
	}

	public int getEntryCountPerOnePage() {
		return entryCountPerOnePage;
	}

	public void setEntryCountPerOnePage(int entryCountPerOnePage) {
		this.entryCountPerOnePage = entryCountPerOnePage;
	}

	public int getPageCountPerPageGroup() {
		return pageCountPerPageGroup;
	}

	public void setPageCountPerPageGroup(int pageCountPerPageGroup) {
		this.pageCountPerPageGroup = pageCountPerPageGroup;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public Paging() {
	}

	public Paging(int entryCountPerOnePage) {
		this.entryCountPerOnePage = entryCountPerOnePage;
	}

	public Paging(int pageNumber, int entryCountPerOnePage, int pageCountPerPageGroup) {
		this.pageNumber = pageNumber;
		this.entryCountPerOnePage = entryCountPerOnePage;
		this.pageCountPerPageGroup = pageCountPerPageGroup;
	}

	public int getFirstOffset(int pageNumber) {
		if (pageNumber < 1) {
			pageNumber = 1;
		}
		return (pageNumber - 1) * entryCountPerOnePage + 1;
	}

	public int getFirstOffset() {
		return getFirstOffset(pageNumber);
	}

	public int getLastOffset(int pageNumber) {
		return getFirstOffset(pageNumber) + entryCountPerOnePage - 1;
	}

	public int getLastOffset() {
		return getLastOffset(pageNumber);
	}

	public int getLastPageNumber() {
		return (int) Math.ceil((float) totalEntryCount / entryCountPerOnePage);
	}

	public int getCurPageNavi() {
		return getCurPageNavi(pageCountPerPageGroup);
	}

	public int getCurPageNavi(int pageCountPerPageGroup) {
		int curPageNavi = pageNumber / pageCountPerPageGroup;
		if (pageNumber % pageCountPerPageGroup > 0) {
			curPageNavi++;
		}

		return curPageNavi;

	}

	public int getTotalNaviCount() {
		return getTotalNaviCount(getLastPageNumber());
	}

	public int getTotalNaviCount(int lastPageNumber) {
		int totalNaviCount = lastPageNumber / pageCountPerPageGroup;
		if (lastPageNumber % pageCountPerPageGroup > 0) {
			totalNaviCount++;
		}
		return totalNaviCount;
	}

	public int getStartPageNumber() {
		return getStartPageNumber(getCurPageNavi());
	}

	public int getStartPageNumber(int curPageNavi) {
		return (curPageNavi - 1) * pageCountPerPageGroup + 1;
	}

	public int getEndPageNumber() {
		return getEndPageNumber(getStartPageNumber());
	}

	public int getEndPageNumber(int startPageNumber) {			
 		return startPageNumber + (pageCountPerPageGroup - 1);
	}

	public String getBaseUrlFormat() {
		return baseUrlFormat;
	}

	public void setBaseUrlFormat(String baseUrlFormat) {
		this.baseUrlFormat = baseUrlFormat;
	}

	/**
	 * 페이징에 사용할 url format
	 *
	 * @param baseUrl
	 * @param queryString
	 * @param pageNumber
	 * @return String
	 */
	public String getPagingBaseUrl(String baseUrl, String queryString, int pageNumber) {
		if (StringUtils2.isEmpty(queryString)) {
			queryString = "pageNumber=1";
		} else if (queryString.indexOf("pageNumber") < 0) {
			queryString = queryString + "&pageNumber=1";
		}
		queryString = queryString.replace("pageNumber=" + pageNumber, "pageNumber=%pageNumber%");

		return baseUrl + "?" + queryString;
	}

	public String printPaging_S(int page, int page_size, int page_cnt, String url, String pImg, String nImg, String pColor, HashMap<String, Object> json) {
		StringBuilder _html = new StringBuilder();

		int n_page = (page - 1) / page_size + 1;
		int s_page = (n_page - 1) * page_size + 1;
		int e_page = n_page * page_size;
		
		StringBuffer addParam= new StringBuffer();
		Iterator<String> keys= json.keySet().iterator();
		while(keys.hasNext()){
			String key= keys.next();
			if(!key.equals("page"))
				addParam.append(String.format("&%s=%s", key, json.get(key)));
		}
		addParam.append("&page=");
		url+= addParam.toString().substring(1);

		if (e_page > page_cnt) {
			e_page = page_cnt;
		}

		if (page > 1) {
			if (page > page_size) {
				_html.append(String.format("<i class=\"prev arrow\"><a href=\"%s%s\">이전</a></i>", url, s_page-1));
			} else {
				_html.append("<i class=\"prev arrow\"><a href=\"#\">이전</a></i>");
			}
		} else {
			_html.append("<i class=\"prev arrow\"><a href=\"#\">이전</a></i>");
		}

		for (int i = s_page; i <= e_page; ++i) {
			if (i == page) {
				_html.append(String.format("<em class=\"num first active\"><a href=\"javascript:;\">%s</a></em>", i));
			} else {
				_html.append(String.format("<em class=\"num\"><a href=\"%s%s\">%s</a></em>", url, i, i));
			}
		}

		if (page < page_cnt) {
			if (s_page + page_size <= page_cnt) {
				_html.append(String.format("<i class=\"next arrow\"><a href=\"%s%s\">다음</a></i>", url, s_page+page_size));
			} else {
				_html.append(String.format("<i class=\"next arrow\"><a href=\"#\">다음</a></i>"));
			}
		} else {
			_html.append(String.format("<i class=\"next arrow\"><a href=\"#\">다음</a></i>"));
		}
		return _html.toString();
	}
	public String addzero(int val, int pos) {
		String sval = "";
		String sbuf = "";
		sval = Integer.toString(val);
		while (pos > 0) {
			if (sval.length() < pos) {
				sbuf = sbuf + "0";
			}
			--pos;
		}
		return sbuf + sval;
	}
	public int pageCnt(int iTotal, int iListSize) {
		int iTmp = 0;
		int tmp = 0;
		if (iTotal == 0) {
			return 1;
		}

		iTmp = iTotal / iListSize;
		tmp = iTotal % iListSize;

		if (tmp > 0) {
			return iTmp + 1;
		}

		return iTmp;
	}
}