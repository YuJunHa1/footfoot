package footfoot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.time.format.DateTimeFormatter;
import footfoot.DAO.PostDAO;
import footfoot.model.Post;

public class ViewHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // 게시글 ID 가져오기
        int post_id = 0;
        if (request.getParameter("post_id") != null) {
            post_id = Integer.parseInt(request.getParameter("post_id"));
        }

        // 유효성 검사
        if (post_id == 0) {
            request.setAttribute("errorMsg", "유효하지 않은 글입니다.");
            return "post"; // 목록 페이지로 이동
        }

        // 게시글 데이터 가져오기
        PostDAO postDAO = new PostDAO();
        Post post = postDAO.getPost(post_id);

        // 게시글 존재 여부 확인
        if (post == null) {
            request.setAttribute("errorMsg", "해당 게시글이 존재하지 않습니다.");
            return "post"; // 목록 페이지로 이동
        }

        // 날짜 포맷팅
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDate = post.getCreated_at().format(formatter);

        // 데이터를 Request 객체에 설정
        request.setAttribute("post", post);
        request.setAttribute("formattedDate", formattedDate);

        return "view"; // view.jsp로 포워딩
    }
}