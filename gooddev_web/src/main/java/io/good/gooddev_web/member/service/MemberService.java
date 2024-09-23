package io.good.gooddev_web.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import io.good.gooddev_web.member.dao.MemberDAO;
import io.good.gooddev_web.member.dto.MemberDTO;

//비즈니스로직 처리
@Service
public class MemberService {

    @Autowired //생성자 주입
    private MemberDAO memberDAO;

    //회원가입
    public void registerMember(MemberDTO member) {
        memberDAO.insertMember(member);
    }
    // 회원 상세보기
    public MemberDTO getMemberById(String mid) {
        return memberDAO.selectMemberById(mid);
    }
    //모든 회원 조회
    public List<MemberDTO> getAllMembers() {
        return memberDAO.selectAllMembers();
    }
    //회원정보 수정
    public void modifyMember(MemberDTO member) {
        memberDAO.modifyMember(member);
    }
    //회원탈퇴 
    public void removeMember(String mid) {
        memberDAO.deleteMember(mid);
    }

}
