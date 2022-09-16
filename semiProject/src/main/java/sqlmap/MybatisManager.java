package sqlmap;

import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisManager {
	//Mybatis의 SqlSession객체 생성
	private static SqlSessionFactory instance;
	
	private MybatisManager() {
		
	}
/*
생성자는 보통 public인데 여기서는 private처리 하여 외부에서 접근이 불가능하다.
웹프로그램 : 웹은 불특정 다수가 접속하여 서비스를 받는다.
요청이 있을 때마다 1명당 1객체 생성해야 함. MybatisManager m=new MybatisManager();
=> 메모리가 늘어나고 서버가 다운될 수 있다.
다수의 객체 생성을 막고 하나의 객체만 생성하여 처리하도록 한다.
이를 싱글톤 패턴 기법이라고 한다.

new해서 접근이 불가능하므로 getInstance()메소드를 통해 우회하여 접근해야 한다.
*/
	
	public static SqlSessionFactory getInstance() {
		Reader reader = null;
		try {
			//getResourceAsReader는 Java Resource의 src의 xml을 읽어들이는 메소드
			reader = Resources.getResourceAsReader("sqlmap/sqlMapConfig.xml");
			instance = new SqlSessionFactoryBuilder().build(reader);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(reader != null) reader.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return instance;
	}

}