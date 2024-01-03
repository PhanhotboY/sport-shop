# unauthenticated user
CREATE USER 'readonly_user'@'%' IDENTIFIED BY 'readPwd';  

GRANT SELECT ON SPORTSWEAR.san_pham TO 'readonly_user'@'%';  

# customer
CREATE USER 'customer'@'%' IDENTIFIED BY 'customerPwd'; 

GRANT SELECT, UPDATE ON SPORTSWEAR.khach_hang TO 'customer'@'%'; 
GRANT INSERT, SELECT, DELETE ON SPORTSWEAR.wishlist TO 'customer'@'%'; 
GRANT INSERT, SELECT, UPDATE, DELETE ON SPORTSWEAR.wl_sp TO 'customer'@'%'; 
GRANT INSERT, SELECT, DELETE ON SPORTSWEAR.gio_hang TO 'customer'@'%'; 
GRANT INSERT, SELECT, UPDATE, DELETE ON SPORTSWEAR.gh_sp TO 'customer'@'%'; 
GRANT SELECT, INSERT ON SPORTSWEAR.don_hang TO 'customer'@'%'; 
GRANT SELECT, INSERT ON SPORTSWEAR.dh_sp TO 'customer'@'%'; 
GRANT SELECT ON SPORTSWEAR.thanh_toan TO 'customer'@'%'; 
GRANT INSERT, SELECT, UPDATE, DELETE ON SPORTSWEAR.danh_gia TO 'customer'@'%'; 

# employee
CREATE USER 'employee'@'%' IDENTIFIED BY 'employeePwd'; 

GRANT SELECT, INSERT, UPDATE, DELETE ON SPORTSWEAR.san_pham TO 'employee'@'%'; 
GRANT SELECT ON SPORTSWEAR.khach_hang TO 'employee'@'%'; 
GRANT SELECT, INSERT, UPDATE, DELETE ON SPORTSWEAR.loai_san_pham TO 'employee'@'%'; 
GRANT SELECT ON SPORTSWEAR.don_hang TO 'employee'@'%'; 
GRANT SELECT, INSERT, UPDATE, DELETE ON SPORTSWEAR.khuyen_mai TO 'employee'@'%'; 

# admin
CREATE USER 'admin'@'%' IDENTIFIED BY 'adminPwd'; 

GRANT EXECUTE ON FUNCTION SPORTSWEAR.* TO 'admin'@'%'; 
GRANT EXECUTE ON PROCEDURE SPORTSWEAR.* TO 'admin'@'%'; 
GRANT GRANT OPTION ON *.* TO 'admin'@'%'; 