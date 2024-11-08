package week11;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NullHandler implements CommandHandler {

	@Override
	public String process(HttpServletRequest request,HttpServletResponse response) {
		request.setAttribute("command", "invalid type");
		return "null.jsp";
	}

}
