CREATE DATABASE SPORTSWEAR;

USE SPORTSWEAR;

CREATE TABLE IF NOT EXISTS loai_san_pham (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ten VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS thuong_hieu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ten VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS san_pham (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_th INT NOT NULL,
    id_lsp INT NOT NULL,
    ten VARCHAR(255) NOT NULL,
    gia DECIMAL(12, 2) NOT NULL,
    so_luong INT UNSIGNED DEFAULT 0,
    mo_ta TEXT
);
    
CREATE TABLE IF NOT EXISTS thuoc_tinh (
    id_sp INT NOT NULL,
    kich_co CHAR(7) NOT NULL,
    mau_sac CHAR(7) NOT NULL,
    so_luong INT UNSIGNED NOT NULL,
    anh VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS khuyen_mai (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phan_tram DECIMAL(5,2) NOT NULL,
    ngay_bd DATE NOT NULL,
    ngay_kt DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS km_lsp (
    id_km INT NOT NULL,
    id_lsp INT NOT NULL,
    PRIMARY KEY (id_km, id_lsp)
);

CREATE TABLE IF NOT EXISTS khach_hang (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ho_ten VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    sdt VARCHAR(20) UNIQUE NOT NULL,
    dia_chi VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS thanh_toan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ten VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS don_hang (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_kh INT NOT NULL,
    id_tt INT NOT NULL,
    dia_chi_giao VARCHAR(255) NOT NULL,
    tong_tien DECIMAL(12, 2) NOT NULL,
    ngay_dat TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS danh_gia (
    id_kh INT NOT NULL,
    id_sp INT NOT NULL,
    diem INT NOT NULL,
    noi_dung TEXT,
    ngay_danh_gia TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ngay_chinh_sua TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id_kh, id_sp)
);

CREATE TABLE IF NOT EXISTS dh_sp (
    id_dh INT NOT NULL,
    id_sp INT NOT NULL,
    so_luong INT UNSIGNED NOT NULL,
    tong_tien DECIMAL(12, 2) NOT NULL,
    PRIMARY KEY (id_dh, id_sp)
);

CREATE TABLE IF NOT EXISTS gio_hang (
    id_gh INT NOT NULL PRIMARY KEY,
    so_luong INT UNSIGNED DEFAULT 0
);

CREATE TABLE IF NOT EXISTS gh_sp (
    id_gh INT NOT NULL,
    id_sp INT NOT NULL,
    so_luong INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_gh, id_sp)
);

CREATE TABLE IF NOT EXISTS wishlist (
    id_wl INT NOT NULL PRIMARY KEY,
    so_luong INT UNSIGNED DEFAULT 0
);

CREATE TABLE IF NOT EXISTS wl_sp (
    id_wl INT NOT NULL,
    id_sp INT NOT NULL,
    PRIMARY KEY (id_wl, id_sp)
);

# khoa ngoai + cac thanh phan lien quan
# loai_san_pham
ALTER TABLE loai_san_pham AUTO_INCREMENT = 1000;

# thuong_hieu
ALTER TABLE thuong_hieu AUTO_INCREMENT = 1000;

# san_pham
ALTER TABLE san_pham AUTO_INCREMENT = 1000;
ALTER TABLE san_pham ADD CONSTRAINT fk_sp_th FOREIGN KEY (id_th) REFERENCES thuong_hieu(id) ON DELETE CASCADE;
ALTER TABLE san_pham ADD CONSTRAINT fk_sp_lsp FOREIGN KEY (id_lsp) REFERENCES loai_san_pham(id) ON DELETE CASCADE;

# thuoc_tinh
ALTER TABLE thuoc_tinh ADD CONSTRAINT fk_tt_sp FOREIGN KEY (id_sp) REFERENCES san_pham(id) ON DELETE CASCADE;

# khuyen_mai
ALTER TABLE khuyen_mai AUTO_INCREMENT = 1000;

# km_lsp
ALTER TABLE km_lsp ADD CONSTRAINT fk_kmlsp_km FOREIGN KEY (id_km) REFERENCES khuyen_mai(id) ON DELETE CASCADE;
ALTER TABLE km_lsp ADD CONSTRAINT fk_kmlsp_lsp FOREIGN KEY (id_lsp) REFERENCES loai_san_pham(id) ON DELETE CASCADE;

# khach_hang
ALTER TABLE khach_hang AUTO_INCREMENT = 1000;

# thanh_toan
ALTER TABLE thanh_toan AUTO_INCREMENT = 1000;

# don_hang
ALTER TABLE don_hang AUTO_INCREMENT = 1000;
ALTER TABLE don_hang ADD CONSTRAINT fk_dh_kh FOREIGN KEY (id_kh) REFERENCES khach_hang(id) ON DELETE CASCADE;
ALTER TABLE don_hang ADD CONSTRAINT fk_dh_tt FOREIGN KEY (id_tt) REFERENCES thanh_toan(id) ON DELETE CASCADE;

# danh_gia
ALTER TABLE danh_gia ADD CONSTRAINT fk_dg_kh FOREIGN KEY (id_kh) REFERENCES khach_hang(id) ON DELETE CASCADE;
ALTER TABLE danh_gia ADD CONSTRAINT fk_dg_sp FOREIGN KEY (id_sp) REFERENCES san_pham(id) ON DELETE CASCADE;

# dh_sp
ALTER TABLE dh_sp ADD CONSTRAINT fk_dhsp_dh FOREIGN KEY (id_dh) REFERENCES don_hang(id) ON DELETE CASCADE;
ALTER TABLE dh_sp ADD CONSTRAINT fk_dhsp_sp FOREIGN KEY (id_sp) REFERENCES san_pham(id) ON DELETE CASCADE;

# gio_hang
ALTER TABLE gio_hang ADD CONSTRAINT fk_gh_kh FOREIGN KEY (id_gh) REFERENCES khach_hang(id) ON DELETE CASCADE;

# gh_sp
ALTER TABLE gh_sp ADD CONSTRAINT fk_ghsp_gh FOREIGN KEY (id_gh) REFERENCES gio_hang(id_gh) ON DELETE CASCADE;
ALTER TABLE gh_sp ADD CONSTRAINT fk_ghsp_sp FOREIGN KEY (id_sp) REFERENCES san_pham(id) ON DELETE CASCADE;

# wishlist
ALTER TABLE wishlist ADD CONSTRAINT fk_wl_kh FOREIGN KEY (id_wl) REFERENCES khach_hang(id) ON DELETE CASCADE;

# wl_sp
ALTER TABLE wl_sp ADD CONSTRAINT fk_wlsp_wl FOREIGN KEY (id_wl) REFERENCES wishlist(id_wl) ON DELETE CASCADE;
ALTER TABLE wl_sp ADD CONSTRAINT fk_wlsp_sp FOREIGN KEY (id_sp) REFERENCES san_pham(id) ON DELETE CASCADE;