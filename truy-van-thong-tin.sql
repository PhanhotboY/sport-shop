# P08 - xoa san pham khoi wishlist
DELIMITER //
CREATE PROCEDURE del_kh_sp_wl(IN id_kh INT, IN id_sp INT)
BEGIN
    DELETE FROM wl_sp
    WHERE id_wl = id_kh AND id_sp = id_sp;
END //
DELIMITER ;

# P09 - xem thong tin gio hang
DELIMITER //
CREATE PROCEDURE view_kh_gh(IN id_kh INT)
BEGIN
    SELECT sp.id, sp.ten, gs.so_luong, gs.tong_tien
    FROM gh_sp gs, san_pham sp
    WHERE gs.id_gh = id_kh AND gs.id_sp = sp.id;
END //
DELIMITER ;

# P10 - them san pham vao gio hang
DELIMITER //
CREATE PROCEDURE add_kh_sp_gh(IN id_kh INT, IN id_sp INT, IN so_luong INT)
BEGIN
    DECLARE num INT;
    
    SELECT COUNT(*) INTO num
    FROM gh_sp
    WHERE id_gh = id_kh AND id_sp = id_sp;
    
    IF num = 0 THEN
        INSERT INTO gh_sp(id_gh, id_sp, so_luong)
        VALUES(id_kh, id_sp, so_luong);
    ELSE
        UPDATE gh_sp
        SET so_luong = so_luong + so_luong
        WHERE id_gh = id_kh AND id_sp = id_sp;
    END IF;
END //
DELIMITER ;

# P11 - thay doi so luong san pham trong gio hang
DELIMITER //
CREATE PROCEDURE up_kh_sp_gh(IN id_kh INT, IN id_sp INT, IN so_luong INT)
BEGIN
    UPDATE gh_sp
    SET so_luong = so_luong
    WHERE id_gh = id_kh AND id_sp = id_sp;
END //
DELIMITER ;

# P12 - xoa san pham khoi gio hang  
DELIMITER //
CREATE PROCEDURE del_kh_sp_gh(IN id_kh INT, IN id_sp INT)
BEGIN
    DELETE FROM gh_sp
    WHERE id_gh = id_kh AND id_sp = id_sp;
END //
DELIMITER ;

# P13 - them don hang
DELIMITER //
CREATE PROCEDURE add_kh_dh (IN id_kh INT, IN id_tt INT, IN dia_chi_giao VARCHAR(255), IN tong_tien DECIMAL(12, 2))
BEGIN
    INSERT INTO don_hang(id_kh, id_tt, dia_chi_giao, tong_tien)
    VALUES(id_kh, id_tt, dia_chi_giao, tong_tien);
END //
DELIMITER ;

# P13 - cap nhat don hang
DELIMITER //
CREATE PROCEDURE up_kh_dh (IN id_dh INT, IN id_tt INT, IN dia_chi_giao VARCHAR(255), IN tong_tien DECIMAL(12, 2))
BEGIN
    UPDATE don_hang
    SET id_tt = id_tt, dia_chi_giao = dia_chi_giao, tong_tien = tong_tien
    WHERE id = id_dh;
END //
DELIMITER ;

# P16 -  them danh gia san pham
DELIMITER //
CREATE PROCEDURE add_kh_sp_dg(IN id_kh INT, IN id_sp INT, IN diem INT, IN noi_dung TEXT)
BEGIN
    DECLARE num INT;
    
    SELECT COUNT(*) INTO num
    FROM danh_gia
    WHERE id_kh = id_kh AND id_sp = id_sp;
    
    IF num = 0 THEN
        INSERT INTO danh_gia(id_kh, id_sp, diem, noi_dung)
        VALUES(id_kh, id_sp, diem, noi_dung);
    ELSE
        UPDATE danh_gia
        SET diem = diem, noi_dung = noi_dung
        WHERE id_kh = id_kh AND id_sp = id_sp;
    END IF;
END //
DELIMITER ;

# P17 - cap nhat danh gia san pham
DELIMITER //
CREATE PROCEDURE up_kh_sp_dg(IN id_kh INT, IN id_sp INT, IN diem INT, IN noi_dung TEXT)
BEGIN
    UPDATE danh_gia
    SET diem = diem, noi_dung = noi_dung
    WHERE id_kh = id_kh AND id_sp = id_sp;
END //
DELIMITER ;

# P18 - xoa danh gia san pham
DELIMITER //
CREATE PROCEDURE del_kh_sp_dg(IN id_kh INT, IN id_sp INT)
BEGIN
    DELETE FROM danh_gia
    WHERE id_kh = id_kh AND id_sp = id_sp;
END //
DELIMITER ;

# F03 - tinh so luong san pham con lai ung voi cap mau sac, kich co tuong ung
DELIMITER //
CREATE FUNCTION cal_sp_tt_sl(id_sp INT, mau_sac CHAR(7), kich_co CHAR(7)) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE num INT;
    
    SELECT SUM(nx.so_luong) INTO num
    FROM nhap_xuat nx
    WHERE tt.id_sp = id_sp AND tt.mau_sac = mau_sac AND tt.kich_co = kich_co;
    
    RETURN COALESCE(num, 0);
END //
DELIMITER ;

# F04 - tinh so luong san pham con lai
DELIMITER //
CREATE FUNCTION cal_sp_sl(id_sp INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE num INT;
    
    SELECT SUM(tt.so_luong) INTO num
    FROM thuoc_tinh tt
    WHERE tt.id_sp = id_sp;
    
    RETURN COALESCE(num, 0);
END //
DELIMITER ;