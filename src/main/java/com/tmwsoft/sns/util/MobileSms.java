package com.tmwsoft.sns.util;

import java.util.Arrays;
import java.util.List;

import com.logic.SqtoMobile;

public class MobileSms {
	
	public static long sendNote(String smsContent, String... mobileArray) {
		String name = "旅游社区";
		String code = "12222223";
		String senduser = "社区管理员";
		int smsPriority = 3;
		// TODO 社区的并发量很小时，不用考虑smsId重复的情况，当用户量增大时，一定要修改该代码
		long smsId = System.currentTimeMillis();
		List<String> mobiles = Arrays.asList(mobileArray);
		try {
			SqtoMobile.sendInstantSMS(name, code, senduser, mobiles, smsContent, smsPriority, smsId);
			// TODO 是否要考虑查询短信发送成功？
		} catch(Exception ex){
			smsId = -1;
		}
		return smsId;
	}
}
