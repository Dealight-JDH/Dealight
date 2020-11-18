package com.dealight.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dealight.domain.Criteria;
import com.dealight.domain.MainStoreJoinVO;
import com.dealight.domain.PageDTO;
import com.dealight.mapper.MainStoreJoinMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class SearchServicImpl implements SearchService {

	private MainStoreJoinMapper mMapper;

//	@Override
//	public List<MainStoreJoinVO> getRadiusStore(Criteria cri) {
//		//StoreLocVO를 모두불러온다.
//		log.info("get List with criteria:" +cri);
//		
//		return mMapper.getListWithPaging(cri);
		
//		log.info("get List with userloc:" +uLoc);
//		List<StoreLocVO> locList = lMapper.getList();
//		//최종 매장번호 저장
//		List<Long> storeIds = new ArrayList<Long>();
//		//매장번호와 거리저장
//		HashMap<Long, Double> store = new HashMap<Long, Double>();
//		
//		
//		//거리를 구한다.
//		for (StoreLocVO loc : locList) {
//			double r = haversine(uLoc.getLat(), uLoc.getLng(), loc.getLat(), loc.getLng());
//			//반경안에 있는 매장번호를  해시맵에 저장
//			if(uLoc.getDistance() >r) {
//				
//				store.put(loc.getStoreId(), r);
//			}
//			//범위안에 매장이 많을 때 제한을 둬야할지 고민중
////			if(storeIds.size() >100)
////				break;
//		}
//		//반경안에 매장이 없을경우
//		if(store.size() == 0 ) {
//			storeIds.add(-1L);
//		}else {
//			List<Map.Entry<Long, Double>> result = new LinkedList<>(store.entrySet());
//			//거리 순으로 정렬 
//			Collections.sort(result, (o1,o2)-> o1.getValue().compareTo(o2.getValue()));
//			//거리순 매장번호를 리스트에 저장
//			log.info(result);
//			for (Entry<Long, Double> entry : result) {
//				storeIds.add(entry.getKey());
//			}
//		}
//		
//		//매장번호에 해당하는 매장의 정보를 불러온다.
//		return mMapper.getListWithPaging(storeIds, cri);
	
//	}

	@Override
	public int getTotal(Criteria cri) {
		
		log.info("get total count");
		
		return mMapper.getTotalCount(cri);
	}

	@Override
	public PageDTO getListstore(Criteria cri) {
		return new PageDTO(cri, mMapper.getTotalCount(cri),
					mMapper.getListWithPaging(cri));
	}
}
