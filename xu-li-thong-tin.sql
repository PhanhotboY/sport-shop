# xuất ra thông tin hồ sơ của 1 khách hàng
DELIMITER //
CREATE PROCEDURE view_customer_detail(IN id_kh INT)
BEGIN
	SELECT ho_ten, sdt, dia_chi, email
    FROM khach_hang kh
    WHERE kh.id = id_kh;
END //
DELIMITER ;

# liệt kê danh sách đơn hàng của 1 khách hàng
DELIMITER //
CREATE PROCEDURE view_customer_dh(IN id_kh INT)
BEGIN
	SELECT dh.id, dh.ngay_dat, dh.dia_chi_giao, dh.tong_tien, tt.ten
    FROM don_hang dh, thanh_toan tt
    WHERE dh.id_kh = id_kh AND dh.id_tt = tt.id;
END //
DELIMITER ;

# xuất ra thông tin chi tiết của 1 đơn hàng
DELIMITER //
CREATE PROCEDURE view_dh_detail(IN id_dh INT)
BEGIN
	SELECT sp.id, sp.ten, ct.so_luong, ct.tong_tien
    FROM dh_sp ct, san_pham sp
    WHERE ct.id_dh = id_dh AND ct.id_sp = sp.id;
END //
DELIMITER ;

# tính số lượng sản phẩm có trong giỏ hàng của 1 khách hàng
DELIMITER //
CREATE FUNCTION cal_num_product_gh(id_kh INT) RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE num INT;
    
    SELECT COUNT(ct.id_sp) INTO num
    FROM gh_sp ct
    WHERE ct.id_gh = id_kh;
        
    RETURN COALESCE(num, 0);
END //
DELIMITER ;

# tính số lượng sản phẩm có trong wishlist của 1 khách hàng
DELIMITER //
CREATE FUNCTION cal_num_product_wl(id_kh INT) RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE num INT;
    
    SELECT COUNT(ct.id_sp) INTO num
    FROM wl_sp ct
    WHERE ct.id_wl = id_kh;
    
    RETURN COALESCE(num, 0);
END //
DELIMITER ;

# tính thành tiền của 1 sản phẩm
DELIMITER //
CREATE FUNCTION cal_total_product(id_sp INT, sl INT, ngay_dat DATE) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
	DECLARE total DECIMAL(10, 2);
    DECLARE percent DECIMAL(5, 2);
    
    SELECT km.phan_tram INTO percent
    FROM san_pham sp, km_lsp kl, khuyen_mai km
    WHERE sp.id = id_sp AND sp.id_lsp = kl.id_lsp AND kl.id_km = km.id
    AND (km.ngay_bd <= ngay_dat AND ngay_dat <= km.ngay_kt);
    
    SELECT sp.gia * sl / 100 * (100 - COALESCE(percent, 0)) INTO total
    FROM san_pham sp
    WHERE sp.id = id_sp;
    
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

# tính thành tiền của 1 đơn hàng
DELIMITER //
CREATE FUNCTION cal_total_dh(id_dh INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
	DECLARE total DECIMAL(10, 2);
    
    SELECT SUM(cal_total_product(ct.id_sp, ct.so_luong, dh.ngay_dat)) INTO total
    FROM dh_sp ct, don_hang dh
    WHERE ct.id_dh = id_dh AND dh.id = ct.id_dh;
    
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

# tính doanh thu trong một tháng
DELIMITER //
CREATE FUNCTION cal_sales_month(m INT, y INT) RETURNS DECIMAL(12, 2)
DETERMINISTIC
BEGIN
	DECLARE sales DECIMAL(12, 2);
    
    SELECT SUM(tong_tien) INTO sales
    FROM don_hang dh
    WHERE MONTH(dh.ngay_dat) = m AND YEAR(dh.ngay_dat) = y;
    
    RETURN COALESCE(sales, 0);
END //
DELIMITER ;

# tính doanh thu trong một quý
# DROP FUNCTION cal_sales_quarter;
DELIMITER //
CREATE FUNCTION cal_sales_quarter(q INT, y INT) RETURNS DECIMAL(12, 2)
DETERMINISTIC
BEGIN
	DECLARE sales DECIMAL(12, 2);
    
    SELECT SUM(tong_tien) INTO sales
    FROM don_hang dh
    WHERE (MONTH(dh.ngay_dat) >= (3*q - 2) AND MONTH(dh.ngay_dat) <= 3*q)
    AND YEAR(dh.ngay_dat) = y;
    
    RETURN COALESCE(sales, 0);
END //
DELIMITER ;

# tính doanh thu trong một năm
DELIMITER //
CREATE FUNCTION cal_sales_year(y INT) RETURNS DECIMAL(12, 2)
DETERMINISTIC
BEGIN
	DECLARE sales DECIMAL(12, 2);
    
    SELECT SUM(tong_tien) INTO sales
    FROM don_hang dh
    WHERE YEAR(dh.ngay_dat) = y;
    
    RETURN COALESCE(sales, 0);
END //
DELIMITER ;