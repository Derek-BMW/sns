package com.tmwsoft.sns.util;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertFalse;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.junit.Test;

public class CommonTest {

//	@Test
	public void verifyRequestUrl() throws UnsupportedEncodingException {
		int max = 50;
		String u = Common.sub_url("http://www.911pop.com/QmoonMusic/Uploaded/Musics/%E9%83%81%E5%8F%AF%E5%94%AF%20%E5%AE%81%E5%A4%8F.mp3", max);
		System.out.println(u);
		assertTrue(!u.startsWith("http://"));
		assertTrue(u.length() <= max);
		String u1 = Common.sub_url("http://www.google.com/search?hl=zh-CN&amp;q=%E5%9B%BE%E7%89%87&amp;um=1&amp;ie=UTF-8&amp;tbm=isch&amp;source=og&amp;sa=N&amp;tab=wi", max);
		System.out.println(u1);
		assertTrue(!u1.startsWith("http://"));
		assertTrue(u1.length() <= max);
		String u2 = Common.sub_url("http://www.google.com/search?hl=zh-CN&amp;q=%E5%9B%BE%E7%89%87&amp;um=1&amp;ie=UTF-8&amp;tbm=isch&amp;source=og&amp;sa=N&amp;tab=爱的自由可口可乐.mp3", max);
		System.out.println(u2);
		assertTrue(!u2.startsWith("http://"));
		assertTrue(u2.length() <= max);
	}

//	@Test
	public void regextest() {
		String regex = "www|space[a-z0-9]*|zone[a-z0-9]*|blog[a-z0-9]*|album[a-z0-9]*|doing[a-z0-9]*|wall[a-z0-9]*|mtag[a-z0-9]*|event[a-z0-9]*|poll[a-z0-9]*|topic[a-z0-9]*|share[a-z0-9]*|pic[a-z0-9]*|feed[a-z0-9]*|friend[a-z0-9]*|top[a-z0-9]*|gift[a-z0-9]*|addrbook[a-z0-9]*|do[a-z0-9]*|wlkst[a-z0-9]*|kst[a-z0-9]*|wl[a-z0-9]*";
		assertTrue("www".matches(regex));
		assertTrue("space".matches(regex));
		assertTrue("space123".matches(regex));
		assertFalse("123space".matches(regex));
		assertFalse("www123".matches(regex));
		assertFalse("asdf123space123".matches(regex));
		assertFalse("asdf123album123".matches(regex));
		assertFalse("34523452345".matches(regex));
		assertFalse("sfasdfasdf".matches(regex));
	}
	
//	@Test
	public void isHoldDomain() {
		Map<String, Object> sConfig = new HashMap<String, Object>();
		sConfig.put("holddomain", "www|space*|zone*|blog*|album*|doing*|wall*|mtag*|event*|poll*|topic*|share*|pic*|feed*|friend*|top*|gift*|addrbook*|do*|wlkst*|kst*|wl*");
		String domain = "space";
		assertTrue(Common.isHoldDomain(sConfig, domain));
		domain = "space123";
		assertTrue(Common.isHoldDomain(sConfig, domain));
		domain = "123space";
		assertTrue(Common.isHoldDomain(sConfig, domain));
		domain = "www123";
		assertFalse(Common.isHoldDomain(sConfig, domain));
		domain = "asdf123space123";
		assertFalse(Common.isHoldDomain(sConfig, domain));
	}
	
	@Test
	public void imgurlcheck() {
		String regex = "(?i),pic:\"(.*?)\"";
		regex = "(?i),pic\\s*=\\s*\'(.*?)\'";
		String input = ",olvl = 7 ,cid = 14 ,time = '02:43' ,pic = 'http://i2.tdimg.com/070/813/077/p.jpg' ,lpic = \"http://i2.tdimg.com/070/813/077/w.jpg\" ,";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(input);
		if (matcher.find()) {
			System.out.println(matcher.group(1));
		}
		input = ",hd:0,dl:true,np:0,pic:\"http://i3.tdimg.com/146/687/256/p.jpg\",time:\"02:23\"";
		pattern = Pattern.compile(regex);
		matcher = pattern.matcher(input);
		if (matcher.find()) {
			System.out.println(matcher.group(1));
		}
	}
}
