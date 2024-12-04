package footfoot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import footfoot.DAO.PostDAO;
import footfoot.model.Post;

public class DeleteHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // 세션에서 사용자 ID 가져오기
        HttpSession session = request.getSession();
        String user_id = (String) session.getAttribute("user_id");

        if (user_id == null) {
            request.setAttribute("errorMsg", "로그인 후에 이용하세요.");
            return "login"; // login.jsp로 포워딩
        }

        // 게시글 ID 가져오기
        int post_id = 0;
        if (request.getParameter("post_id") != null) {
            post_id = Integer.parseInt(request.getParameter("post_id"));
        }

        if (post_id == 0) {
            request.setAttribute("errorMsg", "유효하지 않은 글입니다.");
            return "post"; // post.jsp로 포워딩
        }

        // 게시글 데이터 가져오기
        PostDAO postDAO = new PostDAO();
        Post post = postDAO.getPost(post_id);

        if (post == null) {
            request.setAttribute("errorMsg", "해당 글이 존재하지 않습니다.");
            return "post"; // post.jsp로 포워딩
        }

        // 작성자 확인
        if (!user_id.equals(post.getUser_id())) {
            request.setAttribute("errorMsg", "권한이 없습니다.");
            return "post"; // post.jsp로 포워딩
        }

        // 글 삭제 처리
        int result = postDAO.delete(post_id);

        if (result == -1) {
            request.setAttribute("errorMsg", "글 삭제에 실패했습니다.");
            return "post"; // post.jsp로 포워딩
        }

        // 성공 시 게시판 목록으로 리다이렉트
        response.sendRedirect("post.do");
        return null;
    }
}