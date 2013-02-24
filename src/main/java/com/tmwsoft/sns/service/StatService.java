package com.tmwsoft.sns.service;import java.util.HashMap;import java.util.List;import java.util.Map;import com.tmwsoft.sns.db.DataBaseDao;import com.tmwsoft.sns.util.BeanFactory;import com.tmwsoft.sns.util.Common;public class StatService {	private DataBaseDao dataBaseDao = (DataBaseDao) BeanFactory.getBean("dataBaseDao");	public boolean blogReplyNumStat(int start, int perpage) {		boolean next = false;		Map<Integer, Integer> updates = new HashMap<Integer, Integer>();		List<Map<String, Object>> blogList = dataBaseDao.executeQuery("SELECT blogid, replynum FROM sns_blog LIMIT " + start + "," + perpage);		for (Map<String, Object> value : blogList) {			next = true;			int count = dataBaseDao.findRows("SELECT COUNT(*) FROM sns_comment WHERE id='" + value.get("blogid") + "' AND idtype='blogid'");			if (count != (Integer) value.get("replynum")) {				updates.put((Integer) value.get("blogid"), count);			}		}		if (updates.size() == 0) {			return next;		}		Object[] nums = Common.reNum(updates);		List<Integer> num0 = (List<Integer>) nums[0];		Map<Integer, List<Integer>> num1 = (Map<Integer, List<Integer>>) nums[1];		for (Integer num : num0) {			dataBaseDao.executeUpdate("UPDATE sns_blog SET replynum=" + num + " WHERE blogid IN (" + Common.sImplode(num1.get(num)) + ")");		}		return next;	}	public boolean spaceFriendNumStat(int start, int perpage) {		boolean next = false;		Map<Integer, Integer> updates = new HashMap<Integer, Integer>();		List<Map<String, Object>> spaceList = dataBaseDao.executeQuery("SELECT uid, friendnum FROM sns_space LIMIT " + start + "," + perpage);		for (Map<String, Object> value : spaceList) {			next = true;			int count = dataBaseDao.findRows("SELECT COUNT(*) FROM sns_friend WHERE uid='" + value.get("uid") + "' AND status='1'");			if (count != (Integer) value.get("friendnum")) {				updates.put((Integer) value.get("uid"), count);			}		}		if (updates.size() == 0) {			return next;		}		Object[] nums = Common.reNum(updates);		List<Integer> num0 = (List<Integer>) nums[0];		Map<Integer, List<Integer>> num1 = (Map<Integer, List<Integer>>) nums[1];		for (Integer num : num0) {			dataBaseDao.executeUpdate("UPDATE sns_space SET friendnum=" + num + " WHERE uid IN(" + Common.sImplode(num1.get(num)) + ")");		}		return next;	}	public boolean spaceFriendStat(int start, int perpage) {		boolean next = false;		List<Map<String, Object>> spacefieldList = dataBaseDao.executeQuery("SELECT uid, friend FROM sns_spacefield LIMIT " + start + "," + perpage);		for (Map<String, Object> value : spacefieldList) {			next = true;			List<String> fuids = dataBaseDao.executeQuery("SELECT fuid FROM sns_friend WHERE uid='" + value.get("uid") + "' AND status='1'", 1);			String friend = Common.implode(fuids, ",");			if (!friend.equals(value.get("friend"))) {				dataBaseDao.executeUpdate("UPDATE sns_spacefield SET friend='" + friend + "' WHERE uid='" + value.get("uid") + "'");			}		}		return next;	}	public boolean mtagMemberNumStat(int start, int perpage) {		boolean next = false;		Map<Integer, Integer> updates = new HashMap<Integer, Integer>();		List<Map<String, Object>> mtagList = dataBaseDao.executeQuery("SELECT tagid, membernum FROM sns_mtag LIMIT " + start + "," + perpage);		for (Map<String, Object> value : mtagList) {			next = true;			int count = dataBaseDao.findRows("SELECT COUNT(*) FROM sns_tagspace WHERE tagid='" + value.get("tagid") + "'");			if (count != (Integer) value.get("membernum")) {				updates.put((Integer) value.get("tagid"), count);			}		}		if (updates.size() == 0) {			return next;		}		Object[] nums = Common.reNum(updates);		List<Integer> num0 = (List<Integer>) nums[0];		Map<Integer, List<Integer>> num1 = (Map<Integer, List<Integer>>) nums[1];		for (Integer num : num0) {			dataBaseDao.executeUpdate("UPDATE sns_mtag SET membernum=" + num + " WHERE tagid IN (" + Common.sImplode(num1.get(num)) + ")");		}		return next;	}	public boolean mtagThreadNumStat(int start, int perpage) {		boolean next = false;		Map<Integer, Integer> updates = new HashMap<Integer, Integer>();		List<Map<String, Object>> mtagList = dataBaseDao.executeQuery("SELECT tagid, threadnum FROM sns_mtag LIMIT " + start + "," + perpage);		for (Map<String, Object> value : mtagList) {			next = true;			int count = dataBaseDao.findRows("SELECT COUNT(*) FROM sns_thread WHERE tagid='" + value.get("tagid") + "'");			if (count != (Integer) value.get("threadnum")) {				updates.put((Integer) value.get("tagid"), count);			}		}		if (updates.size() == 0) {			return next;		}		Object[] nums = Common.reNum(updates);		List<Integer> num0 = (List<Integer>) nums[0];		Map<Integer, List<Integer>> num1 = (Map<Integer, List<Integer>>) nums[1];		for (Integer num : num0) {			dataBaseDao.executeUpdate("UPDATE sns_mtag SET threadnum=" + num + " WHERE tagid IN (" + Common.sImplode(num1.get(num)) + ")");		}		return next;	}	public boolean mtagPostNumStat(int start, int perpage) {		boolean next = false;		Map<Integer, Integer> updates = new HashMap<Integer, Integer>();		List<Map<String, Object>> mtagList = dataBaseDao.executeQuery("SELECT tagid, postnum FROM sns_mtag LIMIT " + start + "," + perpage);		for (Map<String, Object> value : mtagList) {			next = true;			int count = dataBaseDao.findRows("SELECT COUNT(*) FROM sns_post WHERE tagid='" + value.get("tagid") + "' AND isthread='0'");			if (count != (Integer) value.get("postnum")) {				updates.put((Integer) value.get("tagid"), count);			}		}		if (updates.size() == 0) {			return next;		}		Object[] nums = Common.reNum(updates);		List<Integer> num0 = (List<Integer>) nums[0];		Map<Integer, List<Integer>> num1 = (Map<Integer, List<Integer>>) nums[1];		for (Integer num : num0) {			dataBaseDao.executeUpdate("UPDATE sns_mtag SET postnum=" + num + " WHERE tagid IN (" + Common.sImplode(num1.get(num)) + ")");		}		return next;	}	public boolean threadReplyNumStat(int start, int perpage) {		boolean next = false;		Map<Integer, Integer> updates = new HashMap<Integer, Integer>();		List<Map<String, Object>> threadList = dataBaseDao.executeQuery("SELECT tid, replynum FROM sns_thread LIMIT " + start + "," + perpage);		for (Map<String, Object> value : threadList) {			next = true;			int count = dataBaseDao.findRows("SELECT COUNT(*) FROM sns_post WHERE tid='" + value.get("tid") + "' AND isthread='0'");			if (count != (Integer) value.get("replynum")) {				updates.put((Integer) value.get("tid"), count);			}		}		if (updates.size() == 0) {			return next;		}		Object[] nums = Common.reNum(updates);		List<Integer> num0 = (List<Integer>) nums[0];		Map<Integer, List<Integer>> num1 = (Map<Integer, List<Integer>>) nums[1];		for (Integer num : num0) {			dataBaseDao.executeUpdate("UPDATE sns_thread SET replynum=" + num + " WHERE tid IN (" + Common.sImplode(num1.get(num)) + ")");		}		return next;	}	public boolean albumPicNumStat(int start, int perpage) {		boolean next = false;		Map<Integer, Integer> updates = new HashMap<Integer, Integer>();		List<Map<String, Object>> albumList = dataBaseDao.executeQuery("SELECT albumid, picnum FROM sns_album LIMIT " + start + "," + perpage);		for (Map<String, Object> value : albumList) {			next = true;			int count = dataBaseDao.findRows("SELECT COUNT(*) FROM sns_pic WHERE albumid='" + value.get("albumid") + "'");			if (count != (Integer) value.get("picnum")) {				updates.put((Integer) value.get("albumid"), count);			}		}		if (updates.size() == 0) {			return next;		}		Object[] nums = Common.reNum(updates);		List<Integer> num0 = (List<Integer>) nums[0];		Map<Integer, List<Integer>> num1 = (Map<Integer, List<Integer>>) nums[1];		for (Integer num : num0) {			dataBaseDao.executeUpdate("UPDATE sns_album SET picnum=" + num + " WHERE albumid IN (" + Common.sImplode(num1.get(num)) + ")");		}		return next;	}	public boolean tagBlogNumStat(int start, int perpage) {		boolean next = false;		Map<Integer, Integer> updates = new HashMap<Integer, Integer>();		List<Map<String, Object>> tagList = dataBaseDao.executeQuery("SELECT tagid, blognum FROM sns_tag LIMIT " + start + "," + perpage);		for (Map<String, Object> value : tagList) {			next = true;			int count = dataBaseDao.findRows("SELECT COUNT(*) FROM sns_tagblog WHERE tagid='" + value.get("tagid") + "'");			if (count != (Integer) value.get("blognum")) {				updates.put((Integer) value.get("tagid"), count);			}		}		if (updates.size() == 0) {			return next;		}		Object[] nums = Common.reNum(updates);		List<Integer> num0 = (List<Integer>) nums[0];		Map<Integer, List<Integer>> num1 = (Map<Integer, List<Integer>>) nums[1];		for (Integer num : num0) {			dataBaseDao.executeUpdate("UPDATE sns_tag SET blognum=" + num + " WHERE tagid IN (" + Common.sImplode(num1.get(num)) + ")");		}		return next;	}	public boolean doingNumStat(int start, int perpage) {		boolean next = false;		Map<Integer, Integer> updates = new HashMap<Integer, Integer>();		List<Map<String, Object>> list = dataBaseDao.executeQuery("SELECT uid, doingnum FROM sns_space LIMIT " + start + "," + perpage);		for (Map<String, Object> value : list) {			next = true;			int count = dataBaseDao.findRows("SELECT COUNT(*) FROM sns_doing WHERE uid='" + value.get("uid") + "'");			if (count != (Integer) value.get("doingnum")) {				updates.put((Integer) value.get("uid"), count);			}		}		if (updates.size() == 0) {			return next;		}		Object[] nums = Common.reNum(updates);		List<Integer> num0 = (List<Integer>) nums[0];		Map<Integer, List<Integer>> num1 = (Map<Integer, List<Integer>>) nums[1];		for (Integer num : num0) {			dataBaseDao.executeUpdate("UPDATE sns_space SET doingnum=" + num + " WHERE uid IN (" + Common.sImplode(num1.get(num)) + ")");		}		return next;	}	public boolean albumNumStat(int start, int perpage) {		boolean next = false;		Map<Integer, Integer> updates = new HashMap<Integer, Integer>();		List<Map<String, Object>> list = dataBaseDao.executeQuery("SELECT uid, albumnum FROM sns_space LIMIT " + start + "," + perpage);		for (Map<String, Object> value : list) {			next = true;			int count = dataBaseDao.findRows("SELECT COUNT(*) FROM sns_album WHERE uid='" + value.get("uid") + "'");			if (count != (Integer) value.get("albumnum")) {				updates.put((Integer) value.get("uid"), count);			}		}		if (updates.size() == 0) {			return next;		}		Object[] nums = Common.reNum(updates);		List<Integer> num0 = (List<Integer>) nums[0];		Map<Integer, List<Integer>> num1 = (Map<Integer, List<Integer>>) nums[1];		for (Integer num : num0) {			dataBaseDao.executeUpdate("UPDATE sns_space SET albumnum=" + num + " WHERE uid IN (" + Common.sImplode(num1.get(num)) + ")");		}		return next;	}	public boolean threadNumStat(int start, int perpage) {		boolean next = false;		Map<Integer, Integer> updates = new HashMap<Integer, Integer>();		List<Map<String, Object>> list = dataBaseDao.executeQuery("SELECT uid, threadnum FROM sns_space LIMIT " + start + "," + perpage);		for (Map<String, Object> value : list) {			next = true;			int count = dataBaseDao.findRows("SELECT COUNT(*) FROM sns_thread WHERE uid='" + value.get("uid") + "'");			if (count != (Integer) value.get("threadnum")) {				updates.put((Integer) value.get("uid"), count);			}		}		if (updates.size() == 0) {			return next;		}		Object[] nums = Common.reNum(updates);		List<Integer> num0 = (List<Integer>) nums[0];		Map<Integer, List<Integer>> num1 = (Map<Integer, List<Integer>>) nums[1];		for (Integer num : num0) {			dataBaseDao.executeUpdate("UPDATE sns_space SET threadnum=" + num + " WHERE uid IN (" + Common.sImplode(num1.get(num)) + ")");		}		return next;	}	public boolean pollNumStat(int start, int perpage) {		boolean next = false;		Map<Integer, Integer> updates = new HashMap<Integer, Integer>();		List<Map<String, Object>> list = dataBaseDao.executeQuery("SELECT uid, pollnum FROM sns_space LIMIT " + start + "," + perpage);		for (Map<String, Object> value : list) {			next = true;			int count = dataBaseDao.findRows("SELECT COUNT(*) FROM sns_poll WHERE uid='" + value.get("uid") + "'");			if (count != (Integer) value.get("pollnum")) {				updates.put((Integer) value.get("uid"), count);			}		}		if (updates.size() == 0) {			return next;		}		Object[] nums = Common.reNum(updates);		List<Integer> num0 = (List<Integer>) nums[0];		Map<Integer, List<Integer>> num1 = (Map<Integer, List<Integer>>) nums[1];		for (Integer num : num0) {			dataBaseDao.executeUpdate("UPDATE sns_space SET pollnum=" + num + " WHERE uid IN (" + Common.sImplode(num1.get(num)) + ")");		}		return next;	}	public boolean eventNumStat(int start, int perpage) {		boolean next = false;		Map<Integer, Integer> updates = new HashMap<Integer, Integer>();		List<Map<String, Object>> list = dataBaseDao.executeQuery("SELECT uid, eventnum FROM sns_space LIMIT " + start + "," + perpage);		for (Map<String, Object> value : list) {			next = true;			int count = dataBaseDao.findRows("SELECT COUNT(*) FROM sns_event WHERE uid='" + value.get("uid") + "'");			if (count != (Integer) value.get("eventnum")) {				updates.put((Integer) value.get("uid"), count);			}		}		if (updates.size() == 0) {			return next;		}		Object[] nums = Common.reNum(updates);		List<Integer> num0 = (List<Integer>) nums[0];		Map<Integer, List<Integer>> num1 = (Map<Integer, List<Integer>>) nums[1];		for (Integer num : num0) {			dataBaseDao.executeUpdate("UPDATE sns_space SET eventnum=" + num + " WHERE uid IN (" + Common.sImplode(num1.get(num)) + ")");		}		return next;	}	public boolean shareNumStat(int start, int perpage) {		boolean next = false;		Map<Integer, Integer> updates = new HashMap<Integer, Integer>();		List<Map<String, Object>> list = dataBaseDao.executeQuery("SELECT uid, sharenum FROM sns_space LIMIT " + start + "," + perpage);		for (Map<String, Object> value : list) {			next = true;			int count = dataBaseDao.findRows("SELECT COUNT(*) FROM sns_share WHERE uid='" + value.get("uid") + "'");			if (count != (Integer) value.get("sharenum")) {				updates.put((Integer) value.get("uid"), count);			}		}		if (updates.size() == 0) {			return next;		}		Object[] nums = Common.reNum(updates);		List<Integer> num0 = (List<Integer>) nums[0];		Map<Integer, List<Integer>> num1 = (Map<Integer, List<Integer>>) nums[1];		for (Integer num : num0) {			dataBaseDao.executeUpdate("UPDATE sns_space SET sharenum=" + num + " WHERE uid IN (" + Common.sImplode(num1.get(num)) + ")");		}		return next;	}}