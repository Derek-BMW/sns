package com.tmwsoft.sns.web.servlet;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.catalina.util.ParameterMap;

import com.tmwsoft.sns.util.Common;

public class HttpServletRequestWrapper extends javax.servlet.http.HttpServletRequestWrapper {
	public HttpServletRequestWrapper(HttpServletRequest request) {
		super(request);
	}

	@Override
	public String getParameter(String name) {
		String value = super.getParameter(name);
		if (value != null) {
			value = Common.addSlashes(value.trim());
			if ("get".equalsIgnoreCase(super.getMethod())) {
				value = Common.htmlSpecialChars(value);
			}
		}
		return value;
	}

	@Override
	public String[] getParameterValues(String name) {
		String[] values = super.getParameterValues(name);
		if (values != null) {
			for (int i = 0; i < values.length; i++) {
				String value = values[i];
				if (value != null) {
					value = Common.addSlashes(value);
					if ("get".equalsIgnoreCase(super.getMethod())) {
						value = Common.htmlSpecialChars(value);
					}
					values[i] = value;
				}
			}
		}
		return values;
	}
	
	@Override
	public Map<String, String[]> getParameterMap() {
		Map<String, String[]> p = super.getParameterMap();
		if(p instanceof ParameterMap) {
			ParameterMap<String, String[]> pm = (ParameterMap<String, String[]>)p;
			pm.setLocked(false);
		}
		return p;
	}
}
