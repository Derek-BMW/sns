package com.tmwsoft.sns.web.filter;import java.io.IOException;import java.io.OutputStream;import javax.servlet.Filter;import javax.servlet.FilterChain;import javax.servlet.FilterConfig;import javax.servlet.ServletException;import javax.servlet.ServletRequest;import javax.servlet.ServletResponse;import javax.servlet.http.HttpServletRequest;import javax.servlet.http.HttpServletResponse;import com.tmwsoft.sns.util.Common;import com.tmwsoft.sns.util.SysConstants;public class AttachmentFilter implements Filter {	public void destroy() {	}	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException,			ServletException {				HttpServletRequest request = (HttpServletRequest) req;		HttpServletResponse response = (HttpServletResponse) res;		String sp = request.getServletPath();		String snsRoot = SysConstants.snsRoot;		String attachDir = SysConstants.snsConfig.get("attachDir");		String attachUrl = SysConstants.snsConfig.get("attachUrl");		String filePath = snsRoot + sp.replace("/" + attachUrl, attachDir);				response.reset();//		response.setHeader("Content-Type", "image/jpeg");		OutputStream output = response.getOutputStream();		Common.copyFileToOutputStream(filePath, output);	}	public void init(FilterConfig arg0) throws ServletException {	}}