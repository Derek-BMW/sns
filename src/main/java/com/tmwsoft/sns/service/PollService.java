package com.tmwsoft.sns.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tmwsoft.sns.util.Common;

public class PollService {
	
	private static final String IMG_TAG = "img";
	private static final String IMG_HTML_TEMP = "<img ctype=\"PollImage\" src=\"${img}\" height=\"100px\" onerror=\"this.src=''image/404.gif'';\"/>";

	/**
	 * 
	 * @param optionContext
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public static Map<String, Object> processOptionContent(String optionContent, HttpServletRequest request, HttpServletResponse response )throws Exception{
		
		Map<String, Object> result = Common.getStrWithWordshield( Common.trim(optionContent), 1000, true, true, 0, 0, request, response);
		String content = (String) result.get("STR");
		List<String> imgs = pickupImg( content );
		String tmp;
		for( String img : imgs ){
			tmp = IMG_HTML_TEMP.replace("${img}", img);
			content = content.replace("["+IMG_TAG+"]"+img+"[/"+IMG_TAG+"]", tmp);
		}
		
		result.put("STR", content);
		return result;
	}
	
	/**
	 * 
	 * @param content
	 * @return
	 */
	public static List<String> pickupImg(String content){
		List<String> imgs = new ArrayList<String>();
		Pattern p = Pattern.compile("\\["+IMG_TAG+"\\][\\s\\S]*?\\[/"+IMG_TAG+"\\]");
		Matcher m = p.matcher(content);
		while(m.find()){
			String str = m.group();
			str = str.replaceAll("\\["+IMG_TAG+"\\]|\\[/"+IMG_TAG+"\\]", "");
			imgs.add(str);
		}		
		return imgs;
	}

}
