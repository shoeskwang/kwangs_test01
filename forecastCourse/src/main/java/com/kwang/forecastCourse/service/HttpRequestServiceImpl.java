package com.kwang.forecastCourse.service;


import java.net.URI;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Service;


@Service
public class HttpRequestServiceImpl implements HttpRequestService {

	@Override
	public String getHttpRequest(String url, String key) throws Exception{
		// TODO Auto-generated method stub
		
		String res="";
		CloseableHttpClient httpClient = HttpClients.createDefault();
		CloseableHttpResponse response = null;
		
		HttpGet httpGet = null;
		HttpEntity entity =null;
		
		httpGet = new HttpGet(url);
		response = httpClient.execute(httpGet);
		
		entity = response.getEntity();
        res = EntityUtils.toString(entity);
        EntityUtils.consume(entity);

		return res;
	}

}
