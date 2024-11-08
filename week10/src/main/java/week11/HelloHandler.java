package week11;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request,HttpServletResponse response) {
		// greeting 요청이 들어온 경우 처리되는 메소드
		request.setAttribute("command", "안녕하세요");
		
		//다음으로 넘길 뷰페이지 이름을 리턴
		return "hello.jsp";
	}

}
