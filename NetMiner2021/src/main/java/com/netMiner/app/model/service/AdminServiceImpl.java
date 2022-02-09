package com.netMiner.app.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.netMiner.app.model.dao.AdminDao;
import com.netMiner.app.model.vo.AdminVo;

@Service
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private AdminDao adminDao;

	@Override
	public String selectDate() {
		return adminDao.selectDate();
	}


	@Override
	public int getAdminCount(Map<String, Object> map) {
		return adminDao.getAdminCount(map);
	}

	@Override
	public List<HashMap<String, Object>> getAdminList(Map<String, Object> map) {
		return adminDao.getAdminList(map);
	}

	@Override
	public HashMap<String, Object> getAdminInfo(Map<String, Object> map) {
		return adminDao.getAdminInfo(map);
	}
	
	@Override
	public void modifyAdminInfo(Map<String, Object> map) {
		adminDao.modifyAdminInfo(map);
	}

	@Override
	public void insertAdminInfo(Map<String, Object> map) {
		adminDao.insertAdminInfo(map);
	}

	@Override
	public void deleteAdminInfo(Map<String, Object> map) {
		adminDao.deleteAdminInfo(map);
	}
	
	


	@Override
	public int getMemberCount(Map<String, Object> map) {
		return adminDao.getMemberCount(map);
	}
	
	@Override
	public List<HashMap<String, Object>> getMemberList(Map<String, Object> map) {
		return adminDao.getMemberList(map);
	}

	@Override
	public HashMap<String, Object> getMemberInfo(Map<String, Object> map) {
		return adminDao.getMemberInfo(map);
	}
	
	@Override
	public void modifyMemberInfo(Map<String, Object> map) {
		adminDao.modifyMemberInfo(map);
	}

	@Override
	public void insertMemberInfo(Map<String, Object> map) {
		adminDao.insertMemberInfo(map);
	}

	@Override
	public void insertMemberInfoDrop(Map<String, Object> map) {
		adminDao.insertMemberInfoDrop(map);
	}

	@Override
	public void deleteMemberInfo(Map<String, Object> map) {
		adminDao.deleteMemberInfo(map);
	}

	@Override
	public void updateSubscript(Map<String, Object> map) {
		adminDao.updateSubscript(map);
	}


	
	

	@Override
	public int getMemberQuitCount(Map<String, Object> map) {
		return adminDao.getMemberQuitCount(map);
	}
	
	@Override
	public List<HashMap<String, Object>> getMemberQuitList(Map<String, Object> map) {
		return adminDao.getMemberQuitList(map);
	}

	@Override
	public HashMap<String, Object> getMemberQuitInfo(Map<String, Object> map) {
		return adminDao.getMemberQuitInfo(map);
	}
	
	@Override
	public void modifyMemberQuitInfo(Map<String, Object> map) {
		adminDao.modifyMemberQuitInfo(map);
	}

	@Override
	public void insertMemberQuitInfo(Map<String, Object> map) {
		adminDao.insertMemberQuitInfo(map);
	}

	@Override
	public void deleteMemberQuitInfo(Map<String, Object> map) {
		adminDao.deleteMemberQuitInfo(map);
	}

	
	
	
	
	

	@Override
	public List<HashMap<String, Object>> getEmailList(Map<String, Object> map) {
		return adminDao.getEmailList(map);
	}

	@Override
	public int getEmailCount(Map<String, Object> map) {
		return adminDao.getEmailCount(map);
	}

	@Override
	public HashMap<String, Object> getEmailDetailInfo(Map<String, Object> map) {
		return adminDao.getEmailDetailInfo(map);
	}
	
	@Override
	public void deleteEmailInfo(HashMap<String, Object> map) {
		adminDao.deleteEmailInfo(map);
	}

	@Override
	public void insertEmailInfo(HashMap<String, Object> map) {
		adminDao.insertEmailInfo(map);
	}

	@Override
	public void modifyEmailInfo(HashMap<String, Object> map) {
		adminDao.modifyEmailInfo(map);
	}

	


	
	

	@Override
	public List<HashMap<String, Object>> getOrderList(Map<String, Object> map) {
		return adminDao.getOrderList(map);
	}

	@Override
	public int getOrderCount(Map<String, Object> map) {
		return adminDao.getOrderCount(map);
	}

	@Override
	public HashMap<String, Object> getOrderDetailInfo(Map<String, Object> map) {
		return adminDao.getOrderDetailInfo(map);
	}
	
	@Override
	public void deleteOrderInfo(HashMap<String, Object> map) {
		adminDao.deleteOrderInfo(map);
	}

	@Override
	public void insertOrderInfo(HashMap<String, Object> map) {
		adminDao.insertOrderInfo(map);
	}

	@Override
	public void modifyOrderInfo(HashMap<String, Object> map) {
		adminDao.modifyOrderInfo(map);
	}


	
	

	@Override
	public List<HashMap<String, Object>> getFaqList(Map<String, Object> map) {
		return adminDao.getFaqList(map);
	}

	@Override
	public int getFaqCount(Map<String, Object> map) {
		return adminDao.getFaqCount(map);
	}

	@Override
	public HashMap<String, Object> getFaqDetailInfo(Map<String, Object> map) {
		return adminDao.getFaqDetailInfo(map);
	}
	
	@Override
	public void deleteFaqInfo(HashMap<String, Object> map) {
		adminDao.deleteFaqInfo(map);
	}

	@Override
	public void insertFaqInfo(HashMap<String, Object> map) {
		adminDao.insertFaqInfo(map);
	}

	@Override
	public void modifyFaqInfo(HashMap<String, Object> map) {
		adminDao.modifyFaqInfo(map);
	}

	
	

	@Override
	public SXSSFWorkbook excelFileDownloadProcess(List<HashMap<String, Object>> list) {
		 SXSSFWorkbook workbook = new SXSSFWorkbook();
	        
	        // 시트 생성
	        SXSSFSheet sheet = workbook.createSheet("USER_INFO");
	        
	        //시트 열 너비 설정
	        sheet.setColumnWidth(0, 1500);
	        sheet.setColumnWidth(0, 3000);
	        sheet.setColumnWidth(0, 3000);
	        sheet.setColumnWidth(0, 1500);
	        
	        // 헤더 행 생
	        Row headerRow = sheet.createRow(0);
	        // 해당 행의 첫번째 열 셀 생성
	        Cell headerCell = headerRow.createCell(0);
	        headerCell.setCellValue("가입일시");
	        // 해당 행의 두번째 열 셀 생성
	        headerCell = headerRow.createCell(1);
	        headerCell.setCellValue("용도");
	        // 해당 행의 세번째 열 셀 생성
	        headerCell = headerRow.createCell(2);
	        headerCell.setCellValue("이메일");
	        // 해당 행의 네번째 열 셀 생성
	        headerCell = headerRow.createCell(3);
	        headerCell.setCellValue("언어");
	        
	        headerCell = headerRow.createCell(4);
	        headerCell.setCellValue("국가");
	        
	        headerCell = headerRow.createCell(5);
	        headerCell.setCellValue("소속");
	        
	        headerCell = headerRow.createCell(6);
	        headerCell.setCellValue("수신동의");
	        
	        // 과일표 내용 행 및 셀 생성
	        Row bodyRow = null;
	        Cell bodyCell = null;
	        for (int i = 0; i < list.size(); i ++) {
	        	HashMap<String , Object> result  = list.get(i);
	        	// 행 생성
	            bodyRow = sheet.createRow(i+1);
	            // 데이터 번호 표시
	            bodyCell = bodyRow.createCell(0);
	            bodyCell.setCellValue(i + 1);
	            // 데이터 이름 표시
	            bodyCell = bodyRow.createCell(1);
	            bodyCell.setCellValue((String) result.get("REG_DATES"));
	            // 데이터 가격 표시
	            bodyCell = bodyRow.createCell(2);
	            bodyCell.setCellValue((String) result.get("USE_CODE"));
	            // 데이터 수량 표시
	            bodyCell = bodyRow.createCell(3);
	            bodyCell.setCellValue((String) result.get("USER_ID"));
	            
	            bodyCell = bodyRow.createCell(4);
	            bodyCell.setCellValue((String) result.get("LANGUAGE"));
	            
	            bodyCell = bodyRow.createCell(5);
	            bodyCell.setCellValue((String) result.get("NATION"));
	            
	            bodyCell = bodyRow.createCell(6);
	            bodyCell.setCellValue((String) result.get("MARKET_YN"));
	            
	        }
	        
	        return workbook;
	}


	@Override
	public void modifyDropMemberInfo(HashMap<String, Object> map) {
		adminDao.modifyDropMemberInfo(map);
	}

	@Override
	public void recoverMemberQuitInfo(HashMap<String, Object> json) {
		adminDao.recoverMemberQuitInfo(json);		
	}

	@Override
	public Map getCheck(HashMap<String, Object> json) {
		return adminDao.getCheck(json);
	}

	@Override
	public void modifyCheck(HashMap<String, Object> json) {
		adminDao.modifyCheck(json);
	}

}
