# gia cua san pham khong duoc nho hon 0
ALTER TABLE san_pham ADD CONSTRAINT c_sp_gia CHECK (gia >= 0);

# ma mau sac phai co dang #xxxxxx voi moi cap x so thap luc phan co gia tri tu 00 den ff
ALTER TABLE thuoc_tinh ADD CONSTRAINT c_tt_ma_mau CHECK (mau_sac REGEXP '^#[a-zA-Z0-9]{6}$');

# so luong san pham con lai bang tong so luong san pham con lai ung voi moi cap mau sac - kich co di kem voi san pham do
DELIMITER //
CREATE TRIGGER t_check_slsp_ins_sp
BEFORE INSERT ON san_pham
FOR EACH ROW
SET NEW.so_luong = 0;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_check_slsp_up_sp
BEFORE UPDATE ON san_pham
FOR EACH ROW
BEGIN
    IF OLD.so_luong <> NEW.so_luong THEN
        SET NEW.so_luong = (
            SELECT COALESCE(SUM(so_luong), 0)
            FROM thuoc_tinh
            WHERE thuoc_tinh.id_sp = NEW.id
        );
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_check_slsp_ins_tt
AFTER INSERT ON thuoc_tinh
FOR EACH ROW
BEGIN
    UPDATE san_pham
    SET san_pham.so_luong = san_pham.so_luong + (NEW.so_luong)
    WHERE san_pham.id = NEW.id_sp;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_check_slsp_up_tt
AFTER UPDATE ON thuoc_tinh
FOR EACH ROW
BEGIN
    UPDATE san_pham
    SET san_pham.so_luong = san_pham.so_luong - OLD.so_luong + NEW.so_luong
    WHERE san_pham.id = NEW.id_sp;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_check_slsp_del_tt
AFTER DELETE ON thuoc_tinh
FOR EACH ROW
BEGIN
    UPDATE san_pham
    SET san_pham.so_luong = san_pham.so_luong - OLD.so_luong
    WHERE san_pham.id = OLD.id_sp;
END //
DELIMITER ;

# gia tri phan tram khuyen mai thuoc (0; 100]
ALTER TABLE khuyen_mai ADD CONSTRAINT c_km_phan_tram CHECK (phan_tram > 0 AND phan_tram <= 100);

# khi them moi mot khuyen mai hoac sua khuyen mai chua ap dung, ngay bat dau phai lon hon ngay hien tai
-- DROP TRIGGER t_check_ngbd_gt_today_ins_km;
DELIMITER //
CREATE TRIGGER t_check_ngbd_gt_today_ins_km
BEFORE INSERT ON khuyen_mai
FOR EACH ROW
BEGIN
	IF NEW.ngay_bd <= CURDATE() THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ngay bat dau phai lon hon ngay hien tai';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_check_ngbd_gt_today_up_km
BEFORE UPDATE ON khuyen_mai
FOR EACH ROW
BEGIN
	IF OLD.ngay_bd > CURDATE() THEN # neu khuyen mai chua ap dung
		IF NEW.ngay_bd <= CURDATE() THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ngay bat dau phai lon hon ngay hien tai';
		END IF;
	END IF;
END //
DELIMITER ;

# khong duoc sua hoac xoa cac khuyen mai da ap dung
DELIMITER //
CREATE TRIGGER t_deny_mod_del_applied_km_up_km
BEFORE UPDATE ON khuyen_mai
FOR EACH ROW
BEGIN
	IF OLD.ngay_bd <= CURDATE() THEN # neu khuyen mai da ap dung
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'khong sua khuyen mai da ap dung';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_deny_mod_del_applied_km_del_km
BEFORE DELETE ON khuyen_mai
FOR EACH ROW
BEGIN
	IF OLD.ngay_bd <= CURDATE() THEN # neu khuyen mai da ap dung
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'khong xoa khuyen mai da ap dung';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_deny_mod_del_applied_km_ins_kmlsp
BEFORE INSERT ON km_lsp
FOR EACH ROW
BEGIN
	IF EXISTS (
		SELECT id FROM khuyen_mai
        WHERE khuyen_mai.id = NEW.id_km
        AND khuyen_mai.ngay_bd <= CURDATE()	# neu khuyen mai da ap dung
    )
    THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'khong sua khuyen mai da ap dung';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_deny_mod_del_applied_km_del_kmlsp
BEFORE DELETE ON km_lsp
FOR EACH ROW
BEGIN
	IF EXISTS (
		SELECT id FROM khuyen_mai
        WHERE khuyen_mai.id = OLD.id_km
        AND khuyen_mai.ngay_bd <= CURDATE()	# neu khuyen mai da ap dung
    )
    THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'khong sua khuyen mai da ap dung';
	END IF;
END //
DELIMITER ;

# ngay ket thuc khuyen_mai khong duoc nho hon ngay bat dau khuyen mai
ALTER TABLE khuyen_mai ADD CONSTRAINT c_km_ngay_bd_kt CHECK (ngay_kt > ngay_bd);

# trong một khoảng thời gian, một loại sản phẩm chỉ được áp dụng tối đa một khuyến mãi
DELIMITER //
CREATE TRIGGER t_lsp_applied_1km_up_km
BEFORE UPDATE ON khuyen_mai
FOR EACH ROW
BEGIN
    DECLARE id_lsp INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur_km_lsp CURSOR FOR
            SELECT id_lsp FROM km_lsp
            WHERE km_lsp.id_km = NEW.id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    IF OLD.ngay_bd <> NEW.ngay_bd OR OLD.ngay_kt <> NEW.ngay_kt THEN
        OPEN cur_km_lsp;

        fetch_loop: LOOP
        FETCH cur_km_lsp INTO id_lsp;
        IF done THEN
            LEAVE fetch_loop;
        END IF;

        IF EXISTS (
            SELECT 1 FROM km_lsp
            WHERE km_lsp.id_lsp = id_lsp
            AND EXISTS (
                SELECT id_km FROM khuyen_mai
                WHERE khuyen_mai.id != NEW.id 
                AND khuyen_mai.id = km_lsp.id_km 
                AND ((NEW.ngay_bd BETWEEN km_lsp.ngay_bd AND km_lsp.ngay_kt)
                OR (NEW.ngay_kt BETWEEN km_lsp.ngay_bd AND km_lsp.ngay_kt))
            )
        )
        THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'trong mot khoang thoi gian, mot loai san pham chi duoc ap dung toi da mot khuyen mai';
        END IF;

        END LOOP fetch_loop;
        CLOSE cur_km_lsp;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_lsp_applied_1km_ins_kmsp
BEFORE INSERT ON km_lsp
FOR EACH ROW
BEGIN
    DECLARE ngaybd DATE;
    DECLARE ngaykt DATE;

    SELECT ngay_bd, ngay_kt INTO ngaybd, ngaykt
    FROM khuyen_mai
    WHERE khuyen_mai.id = NEW.id_km;

    IF EXISTS (
        SELECT 1 FROM km_lsp
        WHERE km_lsp.id_lsp = NEW.id_lsp
        AND (
            SELECT id FROM khuyen_mai
            WHERE khuyen_mai.id != NEW.id_km 
            AND khuyen_mai.id = km_lsp.id_km 
            AND ((khuyen_mai.ngay_bd BETWEEN ngaybd AND ngaykt)
            OR (khuyen_mai.ngay_kt BETWEEN ngaykt AND ngaykt))
        )
    )
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'trong mot khoang thoi gian, mot loai san pham chi duoc ap dung toi da mot khuyen mai';
    END IF;
END //
DELIMITER ;

# tổng giá trị đơn hàng bằng tổng các thành tiền của từng sản phẩm
DELIMITER //
CREATE TRIGGER t_dh_values_ins_dh
BEFORE INSERT ON don_hang
FOR EACH ROW
SET NEW.tong_tien = 0;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_dh_values_up_dh
BEFORE UPDATE ON don_hang
FOR EACH ROW
BEGIN
    IF OLD.tong_tien <> NEW.tong_tien THEN
        SET NEW.tong_tien = cal_total_dh(NEW.id);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_dh_values_ins_dhsp
AFTER INSERT ON dh_sp
FOR EACH ROW
BEGIN
    UPDATE don_hang
    SET don_hang.tong_tien = don_hang.tong_tien + NEW.tong_tien
    WHERE don_hang.id = NEW.id_dh;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_dh_values_up_dhsp
AFTER UPDATE ON dh_sp
FOR EACH ROW
BEGIN
	UPDATE don_hang
	SET don_hang.tong_tien = don_hang.tong_tien - OLD.tong_tien + NEW.tong_tien
	WHERE don_hang.id = NEW.id_dh;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_dh_values_del_dhsp
AFTER DELETE ON don_hang
FOR EACH ROW
BEGIN
    UPDATE don_hang
	SET don_hang.tong_tien = don_hang.tong_tien - OLD.tong_tien
	WHERE don_hang.id = OLD.id;
END //
DELIMITER ;

# thanh tien cua tung san pham: thanh tien = so luong * don gia * (100 - phan tram khuyen mai) / 100
DELIMITER //
CREATE TRIGGER t_dhsp_values_ins_dhsp
BEFORE INSERT ON dh_sp
FOR EACH ROW
BEGIN
    SET NEW.tong_tien = cal_total_product(NEW.id_sp, NEW.so_luong, (SELECT ngay_dat FROM don_hang WHERE don_hang.id = NEW.id_dh));
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_dhsp_values_up_dhsp
BEFORE UPDATE ON dh_sp
FOR EACH ROW
BEGIN
    IF OLD.so_luong <> NEW.so_luong THEN
        SET NEW.tong_tien = cal_total_product(NEW.id_sp, NEW.so_luong, (SELECT ngay_dat FROM don_hang WHERE don_hang.id = NEW.id_dh));
    END IF;
END //
DELIMITER ;

# số lượng sản phẩm trong giỏ hàng bằng tổng số lượng của từng sản phẩm trong giỏ hàng
DELIMITER //
CREATE TRIGGER t_check_slsp_gh_ins_gh
BEFORE INSERT ON gio_hang
FOR EACH ROW
SET NEW.so_luong = 0;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_check_slsp_gh_up_gh
BEFORE UPDATE ON gio_hang
FOR EACH ROW
BEGIN
    IF OLD.so_luong <> NEW.so_luong THEN
		SET NEW.so_luong = cal_num_product_gh(NEW.id_gh);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_check_slsp_gh_ins_ghsp
AFTER INSERT ON gh_sp
FOR EACH ROW
BEGIN
    UPDATE gio_hang
    SET gio_hang.so_luong = gio_hang.so_luong + NEW.so_luong
    WHERE gio_hang.id_gh = NEW.id_gh;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_check_slsp_gh_up_ghsp
AFTER UPDATE ON gh_sp
FOR EACH ROW
BEGIN
    UPDATE gio_hang
    SET gio_hang.so_luong = gio_hang.so_luong - OLD.so_luong + NEW.so_luong
    WHERE gio_hang.id_gh = NEW.id_gh;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_check_slsp_gh_del_ghsp
AFTER DELETE ON gh_sp
FOR EACH ROW
BEGIN
    UPDATE gio_hang
    SET gio_hang.so_luong = gio_hang.so_luong - OLD.so_luong
    WHERE gio_hang.id_gh = OLD.id_gh;
END //
DELIMITER ;

# so luong san pham trong wishlist bang tong so san pham co trong wishlist
DELIMITER //
CREATE TRIGGER t_check_slsp_wl_ins_wl
BEFORE INSERT ON wishlist
FOR EACH ROW
SET NEW.so_luong = 0;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_check_slsp_wl_up_wl
BEFORE UPDATE ON wishlist
FOR EACH ROW
BEGIN
    IF OLD.so_luong <> NEW.so_luong THEN
		SET NEW.so_luong = cal_num_product_wl(NEW.id_wl);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_check_slsp_wl_ins_wlsp
BEFORE INSERT ON wl_sp
FOR EACH ROW
BEGIN
    UPDATE wishlist
    SET wishlist.so_luong = wishlist.so_luong + 1
    WHERE wishlist.id_wl = NEW.id_wl;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER t_check_slsp_wl_del_wlsp
AFTER DELETE ON wl_sp
FOR EACH ROW
BEGIN
    UPDATE wishlist
    SET wishlist.so_luong = wishlist.so_luong - 1
    WHERE wishlist.id_wl = OLD.id_wl;
END //
DELIMITER ;
