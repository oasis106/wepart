package kr.or.ddit.bill.dao;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class CustomSqlSessionFactoryBuilder {
	private static SqlSessionFactory sqlSessionFactory;
	static {
		String resource = "kr/or/ddit/db/mybatis/configuration.xml";
		try(
			InputStream inputStream = Resources.getResourceAsStream(resource);		
		){
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);			
		}catch(IOException e) {
			throw new RuntimeException(e);
		}
	}
	
	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}
}
