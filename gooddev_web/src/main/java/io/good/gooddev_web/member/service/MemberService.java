package io.good.gooddev_web.member.service;


import org.springframework.stereotype.Service;
import io.good.gooddev_web.member.dao.MemberDAO;
import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.vo.MemberVO;
import java.util.List;
import java.util.stream.Collectors;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;

//비즈니스로직 처리
@Service
@RequiredArgsConstructor
public class MemberService {


    private final MapperUtil mapperUtil;
    private final MemberDAO memberDAO;

    public PageResponseDTO<MemberDTO> getMemberList(PageRequestDTO pageRequestDTO) {
    List<MemberDTO> list = memberDAO.getList(pageRequestDTO).
                                        stream().map(member -> mapperUtil.map(member, MemberDTO.class)).collect(Collectors.toList());

    return new PageResponseDTO<MemberDTO>(pageRequestDTO, list, memberDAO.getTotalCount(pageRequestDTO));
    }


    public MemberDTO getRead(String mid) {
    MemberVO member = memberDAO.getReadMember_Optional(mid).orElse(null);
      return member != null ? mapperUtil.map(member, MemberDTO.class) : null; 
    }


    public int removeMember(String uid) {
      return memberDAO.removeMember(uid);
    }

    public int modifyMember(final MemberVO memberDTO) {
      return memberDAO.modifyMember(memberDTO);  
    }


    public int registerMember(final MemberVO memberDTO) {
      return memberDAO.registerMember(memberDTO);
    }

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
