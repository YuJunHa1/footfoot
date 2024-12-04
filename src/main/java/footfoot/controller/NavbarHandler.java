package footfoot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import footfoot.DAO.UserDAO;
import footfoot.model.User;

public class NavbarHandler implements CommandHandler {

	@Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String user_id = (String) request.getSession().getAttribute("user_id");
        String user_name = null;

        if (user_id != null) {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUser(user_id);
            if (user != null) {
                user_name = user.getUser_name();
            }
        }

        request.setAttribute("user_id", user_id);
        request.setAttribute("user_name", user_name);

        return "nav"; // nav.jsp
    }
}
