package cart.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import cart.dto.CartDTO;
import sqlmap.MybatisManager;

public class CartDAO {

	//장바구니 금액
	public List<CartDTO> cart_money() {
		List<CartDTO> items=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			items=session.selectList("cart.product_money");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return items;
	}
	
	//장바구니 추가
	public void insert_cart(CartDTO dto) {
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			session.insert("cart.insert_cart", dto);//장바구니 추가
			session.commit();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//장바구니 목록
	public List<CartDTO> list_cart(String userid) {
		List<CartDTO> list=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			list=session.selectList("cart.list_cart", userid);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//장바구니 수정
	public void update_cart(CartDTO dto) {
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			session.insert("cart.update_cart", dto);//장바구니 추가
			session.commit();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//장바구니 개별 삭제
	public void delete_cart(int cart_id) {
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			session.insert("cart.delete_cart", cart_id);//장바구니 추가
			session.commit();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//장바구니 비우기
	public void clear_cart(String userid) {
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			session.insert("cart.clear_cart", userid);//장바구니 추가
			session.commit();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//장바구니 총금액
	public int sum_money(String userid) {
		int total=0;
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			total=session.selectOne("cart.sum_money", userid);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return total;
	}
}
