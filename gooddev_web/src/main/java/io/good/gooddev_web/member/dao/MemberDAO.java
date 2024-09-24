package io.good.gooddev_web.member.dao;

import org.springframework.stereotype.Repository;

import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.vo.MemberVO;

@Repository
public interface MemberDAO {

    MemberDTO getRead_uuid();

    MemberDTO getLogin(MemberDTO inMember);

    int modify_uuid(MemberVO modify_uuid);

}
