/* **************************************************************
 * @(#)AddFriendHttpServletRequestWrapper.java    1.0, 2012-6-14
 * 
 * System      : Bridge2 Rewards
 * Description : Bridge2 Rewards is the newest innovation in 
 *               the world of incentive, consumer and 
 *               performance rewards. Bridging Performance 
 *               Improvement and Advertising agencies with 
 *               best-in-class retail and service organizations 
 *               to create a new business model for reward 
 *               fulfillment that re-defines the industry.
 * Company     : Bridge2 Solution
 * 
 * Copyright (c) 2008 Bridge2 Solution, Inc. All rights reserved.
 * **************************************************************/
package com.tmwsoft.sns.web.servlet;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * <code>AddFriendHttpServletRequestWrapper.java</code> is the interface of outputting the logs.
 * 
 * @author  Sol Zhang
 * @version 1.0, 2012-6-14
 */
public class AddFriendHttpServletRequestWrapper extends javax.servlet.http.HttpServletRequestWrapper {

	private Map<String, String> addValues;
	
	public AddFriendHttpServletRequestWrapper(HttpServletRequest request, Map<String, String> addValues) {
		super(request);
		this.addValues = addValues;
	}
	
	@Override
	public String getParameter(String name) {
		
		if( this.addValues.get(name) != null ){
			return this.addValues.get(name);
		}
		
		return super.getParameter(name);
	}
	

	

}
