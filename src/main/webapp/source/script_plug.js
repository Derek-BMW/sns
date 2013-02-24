﻿//回到顶部
function goTopEx() {
	var obj = document.getElementById("go_top");
	function getScrollTop() {
		return document.documentElement.scrollTop;
	}
	function setScrollTop(value) {
		document.documentElement.scrollTop = value;
	}
	window.onscroll = function() {
		getScrollTop() > 0 ? obj.style.display = "" : obj.style.display = "none";
	}
	obj.onclick = function() {
		var goTop = setInterval(scrollMove, 10);
		function scrollMove() {
			setScrollTop(getScrollTop() / 1.1);
			if (getScrollTop() < 1)
				clearInterval(goTop);
		}
	}
}