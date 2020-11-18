package com.dealight.mapper;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlVO;
public interface HtdlMapper {
	//핫딜 mapper
	void insert(HtdlVO vo);
	void insertSelectKey(HtdlVO vo);
	HtdlVO findById(Long htdlId);
	List<HtdlVO> getList();
	int update(HtdlVO vo);
	int delete(Long htdlId);
	
	Long getSeqHtdl();
	
	//핫딜 상세 mapper
	void insertDtls(HtdlDtlsVO vo);
	void insertDtlsList(List<HtdlDtlsVO> dtlsList);
	List<HtdlDtlsVO> findDtlsById(Long htdlId);
	int updateDtls(HtdlDtlsVO vo);
	int deleteDtls(Long htdlId);
	
//	//핫딜 결과 mapper
//	void insertRslt(HtdlRsltVO vo);
//	HtdlRsltVO findRsltById(@Param("storeId") Long storeId, @Param("htdlId") Long htdlId);
//	List<HtdlRsltVO> getRsltList(Long storeId);
	
//	//핫딜+상세+매장평가
//	HtdlVO findHtdlById(Long htdlId);
//	List<HtdlVO> getHtdlList();
//	
}
