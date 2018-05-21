package com.kwang.forecastCourse.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

@Service
public class MainServiceImpl implements MainService {
	@Inject
	HttpRequestService httpRequestService;
	
	@Override
	public Map<String, Object> getForecastInfo() throws Exception{
		// TODO Auto-generated method stub
		// Service 부분
    	
    	// 현재 날짜 및 시각 구하기
    	Calendar calendar = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmm");
		
		String date = dateFormat.format(calendar.getTime()).substring(0, 8);
		String time = dateFormat.format(calendar.getTime()).substring(8);
		
//		System.out.println(date);
//		System.out.println(time);
		
		// 검색 시간 조절
		int t = Integer.parseInt(time);
		if(t%100>30){
			t=(t/100)*100;
		}else{
			t=(t/100)*100-100+30;
		}
		
		System.out.println(t);
		
		StringBuilder sb = new StringBuilder();
		sb.append(String.valueOf(t));
		if(t<1000){
			sb.insert(0, '0');
		}
		
		time = sb.toString();
    	
    	// 기상청 데이터 호출
    	String url = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastTimeData?nx=55&ny=127&_type=json&numOfRows=20";
    	//&base_date=20180425&base_time=2200
    	url += "&base_date="+date;
    	url += "&base_time="+time;
    	
    	String key = "fjhxMg0Gy%2FrsTrwToZAddA3z7kHVV0N970UL2rxZDTNpgxxvkmP6EOE2zTFrCga1QqGHbNA%2FSKnmw87UlF0PfQ%3D%3D";
    	
    	//ServiceKey=fjhxMg0Gy%2FrsTrwToZAddA3z7kHVV0N970UL2rxZDTNpgxxvkmP6EOE2zTFrCga1QqGHbNA%2FSKnmw87UlF0PfQ%3D%3D&
    	url +="&ServiceKey="+key;
    	
    	System.out.println("url : " + url);
    	String forecastRes = httpRequestService.getHttpRequest(url, key);
    	
    	// Service 부분
    	JSONParser jsonParser = new JSONParser();
        JSONObject jsonObj = (JSONObject) jsonParser.parse(forecastRes);
        
        jsonObj =  (JSONObject) jsonObj.get("response");
        
        JSONObject headerObj = (JSONObject) jsonObj.get("header");
        JSONObject bodyObj = (JSONObject) jsonObj.get("body");
        
        String result = (String) headerObj.get("resultCode");
        System.out.println("header.resultCode = " + result);
        
        JSONObject itemsObj = (JSONObject) bodyObj.get("items");
        JSONArray item = (JSONArray) itemsObj.get("item");
        
        Iterator<JSONObject> iterator = item.iterator();
        
        JSONObject tempObj;
        String temp="";
        long LGT=-1,PTY=-1,SKY=-1;
        String T1H="999",RN1 = "-1";
        while(iterator.hasNext()){
        	tempObj = iterator.next();
        	if(temp.equals((String) tempObj.get("category"))){
        		continue;
        	}
        	temp = (String) tempObj.get("category");
        	System.out.println(temp);
        	
        	if(temp.equals("LGT")){ // 낙뢰
        		LGT = (long) tempObj.get("fcstValue");
        	}else if(temp.equals("PTY")){ // 강수형태
        		PTY = (long) tempObj.get("fcstValue");
        	}else if(temp.equals("RN1")){ // 강수량
        		if(tempObj.get("fcstValue").getClass().getName().equals("java.lang.Long")){
        			RN1 =String.valueOf((long) tempObj.get("fcstValue"));
        		}else{
        			RN1 =String.valueOf((double) tempObj.get("fcstValue"));
        		}
        	}else if(temp.equals("SKY")){ // 하늘상태
        		SKY = (long) tempObj.get("fcstValue");
        	}else if(temp.equals("T1H")){ // 온도
        		System.out.println("getClass().getName() : "+tempObj.get("fcstValue").getClass().getName());
        		if(tempObj.get("fcstValue").getClass().getName().equals("java.lang.Long")){
        			T1H =String.valueOf((long) tempObj.get("fcstValue"));
        		}else{
        			T1H =String.valueOf((double) tempObj.get("fcstValue"));
        		}
        	}
        }
        
        System.out.println("LGT : " + LGT);
        System.out.println("PTY : " + PTY);
        System.out.println("RN1 : " + RN1);
        System.out.println("SKY : " + SKY);
        System.out.println("T1H : " + T1H);
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("DATE", date);
        map.put("LGT",LGT);
        map.put("PTY",PTY);
        map.put("RN1",RN1);
        map.put("SKY",SKY);
        map.put("T1H",T1H);
        
		return map;
	}

	@Override
	public Map<String, Object> getDustInfo() throws Exception{
		// TODO Auto-generated method stub
		// 미세먼지 데이터 호출
        String url = "http://openapi.seoul.go.kr:8088/4458664c7573686f34376949796d53/json/ForecastWarningMinuteParticleOfDustService/1/1/";
    	//url = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnMesureLIst?itemCode=PM10&dataGubun=DAILY&searchCondition=MONTH&pageNo=1&numOfRows=10&ServiceKey=fjhxMg0Gy%2FrsTrwToZAddA3z7kHVV0N970UL2rxZDTNpgxxvkmP6EOE2zTFrCga1QqGHbNA%2FSKnmw87UlF0PfQ%3D%3D&_returnType=json";
    	String key = "4458664c7573686f34376949796d53";
        //key = "fjhxMg0Gy%2FrsTrwToZAddA3z7kHVV0N970UL2rxZDTNpgxxvkmP6EOE2zTFrCga1QqGHbNA%2FSKnmw87UlF0PfQ%3D%3D";
    	
    	String dustRes = httpRequestService.getHttpRequest(url, key);
    	
    	// dust 데이터 default 오류로 박고 시작
    	String CAISTEP="오류";
        String ALARM_CNDT ="\"비정상 처리 되어 표시할 수 없습니다.\"";
        
        JSONParser jsonParser = new JSONParser();
        JSONObject tempObj;
        
    	// 서버 오류로 인한 XML 데이터 전달시 처리
    	if(!dustRes.substring(0, 1).equals("<")){
    		// Service 부분
    		JSONObject dustObj = (JSONObject) jsonParser.parse(dustRes);
    		
    		dustObj =  (JSONObject) dustObj.get("ForecastWarningMinuteParticleOfDustService");
    		
    		JSONObject dustHeaderObj = (JSONObject) dustObj.get("RESULT");
    		
    		String dustResult = (String) dustHeaderObj.get("CODE");
    		
    		if(dustResult.equals("INFO-000")){
    			JSONArray dustBodyRows = (JSONArray) dustObj.get("row");
    			System.out.println("dustHeaderObj.resultCode = " + dustResult);
    			
    			Iterator<JSONObject> dustIterator = dustBodyRows.iterator();
    			
    			while(dustIterator.hasNext()){
    				tempObj = dustIterator.next();
    				
    				CAISTEP = "\""+(String)tempObj.get("CAISTEP")+"\"";
    				ALARM_CNDT = "\""+(String)tempObj.get("ALARM_CNDT")+"\"";
    				
            	System.out.println(tempObj.get("APPLC_DT"));
            	System.out.println(tempObj.get("CAISTEP"));
            	System.out.println(tempObj.get("ALARM_CNDT"));
    			}
    		}
    	}
    	
        Map<String, Object> dustMap = new HashMap<String, Object>();
        //dustMap.put("APPLC_DT", tempObj.get("APPLC_DT")); //시각 정보
        dustMap.put("CAISTEP", CAISTEP); // String의 경우 \" 추가
    	dustMap.put("ALARM_CNDT", ALARM_CNDT);
    	
		return dustMap;
	}

}
