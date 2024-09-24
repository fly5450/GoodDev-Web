package io.good.gooddev_web.member.service;

import org.springframework.stereotype.Service;

import io.good.gooddev_web.member.dao.MemberDAO;
import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.vo.MemberVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {
    private final MemberDAO memberDAO;

    public MemberDTO getRead_uuid(String value) {
        return memberDAO.getRead_uuid();
    }

    public MemberDTO login(MemberDTO inMember) {
        return memberDAO.getLogin(inMember);
    }

    public int modify_uuid(MemberVO modify_uuid) {
        return memberDAO.modify_uuid(modify_uuid);
    }

}
