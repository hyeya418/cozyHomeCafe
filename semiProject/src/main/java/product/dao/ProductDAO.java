package product.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import product.dto.ProductDTO;
import sqlmap.MybatisManager;

public class ProductDAO {
	
	//상품 목록
	public List<ProductDTO> listProduct(int start, int end) {
		List<ProductDTO> list=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			Map<String,Object> map=new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			list=session.selectList("product.list_product", map);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	//상품 상세 정보
	public ProductDTO detailProduct(int product_code) {
		SqlSession session=MybatisManager.getInstance().openSession();
		ProductDTO dto=session.selectOne("product.detail_product", product_code);
		session.close();	
		return dto;
	}

	//상품 등록
	public void insertProduct(ProductDTO dto) {
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			session.insert("product.insert_product", dto);
			session.commit();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//상품 정보수정
	public void updateProduct(ProductDTO dto) {
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			session.update("product.update_product", dto);
			session.commit();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//상품 삭제
	public void deleteProduct(int product_code) {
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			session.delete("product.delete_product", product_code);
			session.commit();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//신상품 목록
	public List<ProductDTO> newListProduct() {
		List<ProductDTO> list=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			list=session.selectList("product.newList_product");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//상품 검색
	public List<ProductDTO> searchList(String keyword) {
		List<ProductDTO> list=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			list=session.selectList("product.searchList", "%"+keyword+"%");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//게시물 개수 계산
	public int count() {
		int result=0;
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			result=session.selectOne("product.count");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	
}
