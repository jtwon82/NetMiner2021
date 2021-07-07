package com.netMiner.app.util;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.builder.ToStringBuilder;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;

@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
public class Paging {
	private int pageNumber; // 조회하고자하는 페이지 번호
	private int totalEntryCount; // 페이징 대상의 전체 갯수
	private int entryCountPerOnePage; // 한페이지에 보여질 아이템 갯수
	private int pageCountPerPageGroup; // 페이징 부분에서 보여질 페이지의 갯수
	private String baseUrlFormat; // 페이징을 통한 페이지 이동 할 수 있는 url format

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

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
		if (StringUtils.isEmpty(queryString)) {
			queryString = "pageNumber=1";
		} else if (queryString.indexOf("pageNumber") < 0) {
			queryString = queryString + "&pageNumber=1";
		}
		queryString = queryString.replace("pageNumber=" + pageNumber, "pageNumber=%pageNumber%");

		return baseUrl + "?" + queryString + "#list";
	}

	public String printPaging_S(int page, int page_size, int page_cnt, String url, String pImg, String nImg, String pColor) {
		StringBuilder _html = new StringBuilder();

		int n_page = (page - 1) / page_size + 1;
		int s_page = (n_page - 1) * page_size + 1;
		int e_page = n_page * page_size;

		if (e_page > page_cnt) {
			e_page = page_cnt;
		}

		if (page > 1) {
			if (page > page_size) {
				_html.append("<a href=\"");
				_html.append(url);
				_html.append(s_page - 1);
				_html.append("\"><</a>");
			} else {
				_html.append("<");
			}
		} else {
			_html.append("<");
		}

		_html.append(" &nbsp;");

		for (int i = s_page; i <= e_page; ++i) {
			if (i == page) {
				_html.append("<font color='");
				_html.append(pColor);
				_html.append("'>");
				_html.append(addzero(i, 2));
				_html.append("</font>");
			} else {
				_html.append("<a href=\"");
				_html.append(url);
				_html.append(i);
				_html.append("\">");
				_html.append(addzero(i, 2));
				_html.append("</a>");
			}
			if (i != e_page) {
				_html.append(" &nbsp;| ");
			} else {
				_html.append(" &nbsp; ");
			}

		}

		if (page < page_cnt) {
			if (s_page + page_size <= page_cnt) {
				_html.append("<a href=\"");
				_html.append(url);
				_html.append(s_page + page_size);
				_html.append("\" class='brn01'>></a>");
			} else {
				_html.append(">");
			}
		} else {
			_html.append(">");
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