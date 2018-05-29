package com.hxy.core.channel.service;

import java.util.List;
import java.util.Map;
import com.hxy.base.entity.DataGrid;
import com.hxy.core.channel.entity.NewsTag;


public interface NewsChannelService
{
	DataGrid<NewsTag> dataGrid(Map<String, Object> map);
	
	long countNewsTag(Map<String, Object> map);
	
	List<NewsTag> selectNewsTagList(Map<String, Object> map);
	
	List<NewsTag> selectAll2(Map<String, Object> map);
	
	void save(NewsTag newsTag);
	
	void delete(String ids);
	
	NewsTag selectById2(long tagId);

	void update(NewsTag newsTag);

	String selectTagbytagId(long tagId);
	
}