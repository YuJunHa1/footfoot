package week11;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DateHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		// date 요청이 들어왔을 때 처리되는 부분
		request.setAttribute("command", new Date());
		
		// 뷰 페이지 리턴
		return "date.jsp";
	}

}
