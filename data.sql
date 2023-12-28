SET SQL_SAFE_UPDATES = 0;
DELETE FROM loai_san_pham;
DELETE FROM thuong_hieu;
DELETE FROM san_pham;
DELETE FROM thuoc_tinh;
DELETE FROM khuyen_mai;
DELETE FROM km_lsp;
DELETE FROM khach_hang;
DELETE FROM thanh_toan;
DELETE FROM don_hang;
DELETE FROM danh_gia;
DELETE FROM dh_sp;
DELETE FROM gio_hang;
DELETE FROM gh_sp;
DELETE FROM wishlist;
DELETE FROM wl_sp;

INSERT INTO loai_san_pham (ten) VALUES
('Bóng đá'),
('Bóng rổ'),
('Bóng chuyền'),
('Cầu lông'),
('Tennis'),
('Bơi lội'),
('Leo núi'),
('Dãn cơ'),
('Yoga'),
('Bơi nước ngoại ô'),
('Trượt tuyết'),
('Đạp xe địa hình'),
('Đi bộ'),
('Thể dục dụng cụ'),
('Quần áo thể thao'),
('Giày thể thao'),
('Kính thể thao'),
('Dụng cụ tập gym'),
('Túi xách thể thao'),
('Nước uống thể thao'),
('Đèn đeo đầu chạy bộ'),
('Bình nước chống rò rỉ'),
('Bảo vệ cổ tay'),
('Bình nước sạch');

INSERT INTO thuong_hieu (ten) VALUES
('Nike'),
('Adidas'),
('Puma'),
('Under Armour'),
('Reebok'),
('New Balance'),
('Asics'),
('Fila'),
('Converse'),
('Vans'),
('Salomon'),
('Columbia'),
('The North Face'),
('Lululemon'),
('Yonex'),
('Wilson'),
('Head'),
('Speedo'),
('Oakley'),
('Gymshark'),
('Everlast'),
('Mizuno'),
('Skechers'),
('Billabong'),
('Quiksilver');

INSERT INTO san_pham (id_th, id_lsp, ten, gia, so_luong, mo_ta) VALUES
(1000, 1001, 'Nike Air Max 270', 150.99, 50, 'Giày thể thao chạy bộ Nike Air Max 270'),
(1001, 1003, 'Adidas Predator 20.3', 79.99, 30, 'Bóng đá Adidas Predator 20.3'),
(1002, 1005, 'Mizuno Wave Lightning Z6', 129.99, 20, 'Bóng chuyền Mizuno Wave Lightning Z6'),
(1003, 1007, 'Yonex Duora 77', 189.99, 15, 'Vợt cầu lông Yonex Duora 77'),
(1004, 1009, 'Wilson Pro Staff RF97', 249.99, 10, 'Vợt tennis Wilson Pro Staff RF97'),
(1005, 1011, 'Speedo Endurance+', 39.99, 40, 'Áo tắm bơi Speedo Endurance+'),
(1006, 1013, 'The North Face Resolve', 129.99, 25, 'Áo khoác chống nước The North Face Resolve'),
(1007, 1015, 'Lululemon Align Pant', 89.99, 35, 'Quần thể thao Lululemon Align Pant'),
(1008, 1017, 'Under Armour Charged Assert 8', 64.99, 50, 'Giày chạy bộ Under Armour Charged Assert 8'),
(1009, 1019, 'Salomon XA Pro 3D', 129.99, 15, 'Giày leo núi Salomon XA Pro 3D'),
(1010, 1021, 'Everlast Pro Style Training Gloves', 29.99, 30, 'Găng tay tập luyện Everlast Pro Style'),
(1011, 1023, 'Columbia Silver Ridge Lite', 79.99, 20, 'Áo ngoại cỡ Columbia Silver Ridge Lite'),
(1012, 1002, 'Puma Ignite XT', 69.99, 40, 'Giày tập gym Puma Ignite XT'),
(1013, 1004, 'Converse Chuck Taylor All Star', 49.99, 25, 'Giày thể thao Converse Chuck Taylor All Star'),
(1014, 1006, 'Vans Old Skool', 59.99, 30, 'Giày thể thao Vans Old Skool'),
(1015, 1008, 'Fila Disruptor II', 79.99, 15, 'Giày thể thao Fila Disruptor II'),
(1016, 1010, 'Asics Gel-Kayano 27', 159.99, 20, 'Giày chạy bộ Asics Gel-Kayano 27'),
(1017, 1012, 'Oakley Radar EV Path', 149.99, 10, 'Kính thể thao Oakley Radar EV Path'),
(1018, 1014, 'Gymshark Flex Leggings', 49.99, 30, 'Quần legging tập gym Gymshark Flex'),
(1019, 1016, 'Mizuno Wave Rider 24', 129.99, 25, 'Giày chạy bộ Mizuno Wave Rider 24'),
(1020, 1018, 'Quiksilver Waterman Paddle Short', 34.99, 40, 'Quần boardshort Quiksilver Waterman Paddle'),
(1021, 1020, 'Bình nước CamelBak Chute Mag', 14.99, 50, 'Bình nước thể thao CamelBak Chute Mag'),
(1022, 1022, 'Head Ti.S6', 89.99, 15, 'Vợt tennis Head Ti.S6');

INSERT INTO thuoc_tinh (id_sp, kich_co, mau_sac, so_luong, anh) VALUES
(1000, 'S', '#FF0000', 10, 'red_shoe.jpg'),
(1000, 'M', '#00FF00', 15, 'green_shoe.jpg'),
(1000, 'L', '#0000FF', 20, 'blue_shoe.jpg'),
(1001, '4', '#FFFFFF', 25, 'white_ball.jpg'),
(1001, '5', '#000000', 30, 'black_ball.jpg'),
(1002, 'M', '#FFFF00', 15, 'yellow_shoe.jpg'),
(1002, 'L', '#FF00FF', 10, 'purple_shoe.jpg'),
(1003, 'XL', '#00FFFF', 5, 'cyan_shoe.jpg'),
(1003, 'XXL', '#FFA500', 8, 'orange_shoe.jpg'),
(1004, 'S', '#008000', 12, 'green_racket.jpg'),
(1004, 'M', '#800080', 18, 'purple_racket.jpg'),
(1005, 'L', '#FF4500', 22, 'orange_racket.jpg'),
(1005, 'XL', '#000080', 25, 'navy_racket.jpg'),
(1006, 'M', '#8B0000', 30, 'maroon_swimsuit.jpg'),
(1006, 'L', '#800000', 20, 'maroon_swimshorts.jpg'),
(1007, 'S', '#800080', 15, 'purple_jacket.jpg'),
(1007, 'M', '#FFD700', 18, 'gold_jacket.jpg'),
(1008, 'L', '#7CFC00', 25, 'green_shoes.jpg'),
(1008, 'XL', '#CD853F', 20, 'peru_shoes.jpg'),
(1009, 'S', '#87CEEB', 10, 'skyblue_hiking.jpg'),
(1009, 'M', '#F08080', 15, 'lightcoral_hiking.jpg'),
(1010, 'L', '#696969', 22, 'dimgray_gloves.jpg'),
(1010, 'XL', '#800000', 28, 'maroon_gloves.jpg'),
(1011, 'M', '#FF4500', 18, 'orange_shirt.jpg'),
(1011, 'L', '#40E0D0', 25, 'turquoise_shirt.jpg');

INSERT INTO khuyen_mai (phan_tram, ngay_bd, ngay_kt) VALUES
(10.00, '2024-01-01', '2024-01-15'),
(15.00, '2024-02-01', '2024-02-28'),
(20.00, '2024-03-15', '2024-04-15'),
(25.00, '2024-04-01', '2024-04-30'),
(30.00, '2024-05-10', '2024-06-10'),
(12.50, '2024-06-01', '2024-06-15'),
(18.75, '2024-07-01', '2024-07-31'),
(22.50, '2024-08-15', '2024-09-15'),
(27.50, '2024-09-01', '2024-09-30'),
(35.00, '2024-10-10', '2024-11-10'),
(15.00, '2024-11-01', '2024-11-15'),
(10.00, '2024-12-01', '2024-12-31'),
(5.00, '2024-01-01', '2024-01-15'),
(25.00, '2024-02-01', '2024-02-29'),
(20.00, '2024-03-15', '2024-04-15'),
(15.00, '2024-04-01', '2024-04-30'),
(30.00, '2024-05-10', '2024-06-10'),
(12.50, '2024-06-01', '2024-06-15'),
(18.75, '2024-07-01', '2024-07-31'),
(22.50, '2024-08-15', '2024-09-15'),
(27.50, '2024-09-01', '2024-09-30'),
(35.00, '2024-10-10', '2024-11-10'),
(15.00, '2024-11-01', '2024-11-15'),
(10.00, '2024-12-01', '2024-12-31'),
(5.00, '2025-01-01', '2025-01-15');

INSERT INTO km_lsp (id_km, id_lsp) VALUES
(1000, 1000),
(1000, 1001),
(1000, 1002),
(1001, 1003),
(1001, 1004),
(1002, 1005),
(1002, 1006),
(1003, 1007),
(1003, 1008),
(1004, 1009),
(1004, 1010),
(1005, 1011),
(1005, 1012),
(1006, 1013),
(1006, 1014),
(1007, 1015),
(1007, 1016),
(1008, 1017),
(1008, 1018),
(1009, 1019),
(1009, 1020),
(1010, 1021),
(1010, 1022),
(1011, 1023);

INSERT INTO khach_hang (ho_ten, email, sdt, dia_chi) VALUES
('Nguyen Van A', 'vana@gmail.com', '0901234567', '123 Nguyen Van A Street, District 1, Ho Chi Minh City'),
('Tran Thi B', 'btran@yahoo.com', '0912345678', '456 Tran Thi B Street, District 2, Ho Chi Minh City'),
('Le Minh C', 'cle@gmail.com', '0923456789', '789 Le Minh C Street, District 3, Ho Chi Minh City'),
('Pham Van D', 'dpham@gmail.com', '0934567890', '234 Pham Van D Street, District 4, Ho Chi Minh City'),
('Truong Van E', 'etruong@gmail.com', '0945678901', '567 Truong Van E Street, District 5, Ho Chi Minh City'),
('Hoang Thi F', 'fhoang@gmail.com', '0956789012', '890 Hoang Thi F Street, District 6, Ho Chi Minh City'),
('Nguyen Van G', 'gnguyen@gmail.com', '0967890123', '123 Nguyen Van G Street, District 7, Ho Chi Minh City'),
('Le Thi H', 'hle@gmail.com', '0978901234', '456 Le Thi H Street, District 8, Ho Chi Minh City'),
('Vu Van I', 'ivu@gmail.com', '0989012345', '789 Vu Van I Street, District 9, Ho Chi Minh City'),
('Tran Van J', 'jtran@gmail.com', '0990123456', '234 Tran Van J Street, District 10, Ho Chi Minh City'),
('Nguyen Van K', 'knguyen@gmail.com', '0911122233', '567 Nguyen Van K Street, District 11, Ho Chi Minh City'),
('Le Van L', 'lle@gmail.com', '0922233344', '890 Le Van L Street, District 12, Ho Chi Minh City'),
('Pham Van M', 'mpham@gmail.com', '0933344455', '123 Pham Van M Street, Binh Tan District, Ho Chi Minh City'),
('Truong Van N', 'ntruong@gmail.com', '0944455566', '456 Truong Van N Street, Binh Thanh District, Ho Chi Minh City'),
('Hoang Thi O', 'oht@gmail.com', '0955566677', '789 Hoang Thi O Street, Go Vap District, Ho Chi Minh City'),
('Nguyen Van P', 'pnguyen@gmail.com', '0966677788', '123 Nguyen Van P Street, Tan Binh District, Ho Chi Minh City'),
('Le Thi Q', 'qle@gmail.com', '0977788899', '456 Le Thi Q Street, Tan Phu District, Ho Chi Minh City'),
('Vu Van R', 'rvu@gmail.com', '0988899000', '789 Vu Van R Street, Thu Duc District, Ho Chi Minh City'),
('Tran Van S', 'stran@gmail.com', '0999000111', '234 Tran Van S Street, Binh Chanh District, Ho Chi Minh City'),
('Nguyen Van T', 'tnguyen@gmail.com', '0911111222', '567 Nguyen Van T Street, Cu Chi District, Ho Chi Minh City'),
('Le Thi U', 'ule@gmail.com', '0922222333', '890 Le Thi U Street, Hoc Mon District, Ho Chi Minh City'),
('Pham Van V', 'vpham@gmail.com', '0933333444', '123 Pham Van V Street, Nha Be District, Ho Chi Minh City'),
('Truong Van X', 'xtruong@gmail.com', '0944444555', '456 Truong Van X Street, Can Gio District, Ho Chi Minh City'),
('Hoang Thi Y', 'yht@gmail.com', '0955555666', '789 Hoang Thi Y Street, District 8, Ho Chi Minh City'),
('Nguyen Van Z', 'znguyen@gmail.com', '0966666777', '123 Nguyen Van Z Street, District 7, Ho Chi Minh City');

INSERT INTO thanh_toan (ten) VALUES
('Credit Card'),
('PayPal'),
('Cash on Delivery'),
('Bank Transfer'),
('Google Pay');

INSERT INTO don_hang (id_kh, id_tt, dia_chi_giao, tong_tien, ngay_dat) VALUES
(1000, 1000, '123 Nguyen Van A Street, District 1, HCMC', 250.50, '2023-01-05 12:30:00'),
(1001, 1000, '456 Tran Thi B Street, District 2, HCMC', 150.75, '2023-02-10 15:45:00'),
(1002, 1000, '789 Le Minh C Street, District 3, HCMC', 320.00, '2023-03-20 09:00:00'),
(1003, 1001, '234 Pham Van D Street, District 4, HCMC', 180.25, '2023-04-15 18:20:00'),
(1004, 1001, '567 Truong Van E Street, District 5, HCMC', 420.75, '2023-05-02 14:10:00'),
(1005, 1002, '890 Hoang Thi F Street, District 6, HCMC', 275.00, '2023-06-08 11:30:00'),
(1006, 1002, '123 Nguyen Van G Street, District 7, HCMC', 190.50, '2023-07-12 17:15:00'),
(1007, 1003, '456 Le Thi H Street, District 8, HCMC', 150.25, '2023-08-25 08:45:00'),
(1008, 1003, '789 Vu Van I Street, District 9, HCMC', 280.75, '2023-09-30 20:05:00'),
(1009, 1004, '234 Tran Van J Street, District 10, HCMC', 195.00, '2023-10-18 10:20:00'),
(1010, 1004, '567 Nguyen Van K Street, District 11, HCMC', 320.50, '2023-11-25 13:40:00'),
(1011, 1003, '890 Le Van L Street, District 12, HCMC', 210.75, '2023-12-12 19:55:00'),
(1012, 1001, '123 Pham Van M Street, Binh Tan District, HCMC', 175.00, '2024-01-08 07:10:00'),
(1012, 1003, '456 Truong Van N Street, Binh Thanh District, HCMC', 280.25, '2024-02-15 16:30:00'),
(1012, 1001, '789 Hoang Thi O Street, Go Vap District, HCMC', 220.50, '2024-03-22 14:45:00'),
(1015, 1002, '123 Nguyen Van P Street, Tan Binh District, HCMC', 300.75, '2024-04-10 10:05:00'),
(1015, 1002, '456 Le Thi Q Street, Tan Phu District, HCMC', 190.00, '2024-05-18 18:20:00'),
(1015, 1004, '789 Vu Van R Street, Thu Duc District, HCMC', 240.25, '2024-06-02 09:35:00'),
(1018, 1001, '234 Tran Van S Street, Binh Chanh District, HCMC', 180.50, '2024-07-05 12:50:00'),
(1019, 1001, '567 Nguyen Van T Street, Cu Chi District, HCMC', 260.75, '2024-08-11 14:15:00'),
(1020, 1003, '890 Le Thi U Street, Hoc Mon District, HCMC', 200.00, '2024-09-20 08:30:00'),
(1021, 1002, '123 Pham Van V Street, Nha Be District, HCMC', 320.25, '2024-10-15 17:45:00'),
(1022, 1004, '456 Truong Van X Street, Can Gio District, HCMC', 240.50, '2024-11-22 11:00:00'),
(1023, 1004, '789 Hoang Thi Y Street, District 8, HCMC', 180.75, '2024-12-30 19:15:00'),
(1024, 1000, '123 Nguyen Van Z Street, District 7, HCMC', 300.00, '2025-01-25 09:30:00');

INSERT INTO danh_gia (id_kh, id_sp, diem, noi_dung) VALUES
(1000, 1001, 5, 'Sản phẩm tuyệt vời! Rất thoải mái và phong cách.'),
(1001, 1002, 4, 'Chất lượng tốt, nhưng kích thước lớn hơn dự kiến.'),
(1002, 1003, 5, 'Tuyệt vời! Thiết bị thể thao tốt nhất mà tôi từng sử dụng.'),
(1003, 1004, 3, 'Chất lượng tốt, nhưng giá hơi cao.'),
(1004, 1005, 4, 'Vợt tennis tuyệt vời! Cung cấp kiểm soát và sức mạnh tốt.'),
(1005, 1006, 5, 'Hoàn hảo cho việc bơi lội! Chất liệu bền và thoải mái.'),
(1006, 1007, 4, 'Áo khoác đẹp, nhưng màu sắc hơi khác so với hình ảnh.'),
(1007, 1008, 3, 'Giày trung bình, không thoải mái như mong đợi.'),
(1008, 1009, 5, 'Giày chạy nổi bật! Hỗ trợ tốt và nhẹ nhàng.'),
(1009, 1010, 4, 'Bốt leo núi xuất sắc, hỗ trợ mắt cá chân tốt.'),
(1010, 1011, 2, 'Găng tay quá mỏng và không phù hợp cho bài tập mạnh.'),
(1011, 1012, 5, 'Áo chất lượng cao, vải thoải mái và thoáng khí.'),
(1012, 1013, 4, 'Thiết kế đẹp và chất lượng giày tập gym tốt.'),
(1013, 1014, 5, 'Giày sneaker cổ điển và phong cách, tôi rất thích!'),
(1014, 1015, 3, 'Sản phẩm khá, nhưng có nhiều lựa chọn tốt hơn.'),
(1015, 1016, 4, 'Giày thoải mái và phong cách, phù hợp cho việc đi chơi.'),
(1016, 1017, 5, 'Áo khoác hàng đầu! Giữ tôi khô trong thời tiết mưa.'),
(1017, 1018, 2, 'Không hài lòng với chất lượng của legging.'),
(1018, 1019, 4, 'Đôi giày tốt cho các hoạt động ngoại ô.'),
(1019, 1020, 5, 'Rất khuyến khích! Giày leo núi bền và thoải mái.'),
(1020, 1021, 3, 'Chất lượng trung bình của quần short, không xứng đáng với giá.'),
(1021, 1022, 4, 'Bình nước bền, thuận tiện cho các hoạt động thể thao.');

INSERT INTO dh_sp (id_dh, id_sp, so_luong, tong_tien) VALUES
(1000, 1000, 2, 75.50),
(1000, 1001, 3, 120.75),
(1001, 1002, 1, 60.00),
(1001, 1003, 2, 90.25),
(1002, 1004, 1, 210.75),
(1002, 1005, 2, 150.00),
(1003, 1006, 1, 95.50),
(1003, 1007, 2, 75.25),
(1004, 1008, 1, 140.75),
(1004, 1009, 2, 195.00),
(1005, 1010, 1, 160.50),
(1005, 1011, 3, 211.75),
(1006, 1012, 1, 120.00),
(1006, 1013, 2, 155.25),
(1007, 1014, 1, 110.50),
(1007, 1015, 2, 150.75),
(1008, 1016, 1, 190.00),
(1008, 1017, 2, 120.25),
(1009, 1018, 1, 180.50),
(1009, 1019, 2, 260.75),
(1010, 1020, 1, 150.00),
(1010, 1021, 3, 200.25),
(1011, 1022, 1, 240.50),
(1014, 1007, 1, 110.50),
(1015, 1007, 2, 150.75),
(1016, 1008, 1, 190.00),
(1017, 1008, 2, 120.25),
(1018, 1009, 1, 180.50),
(1019, 1009, 2, 260.75),
(1020, 1010, 1, 150.00),
(1021, 1010, 3, 200.25),
(1022, 1011, 1, 240.50),
(1023, 1011, 2, 180.75),
(1024, 1012, 1, 140.00);

INSERT INTO gio_hang (id_gh, so_luong) VALUES
(1000, 35),
(1001, 15),
(1002, 25),
(1003, 45),
(1004, 15),
(1005, 25),
(1006, 3),
(1007, 1),
(1008, 2),
(1009, 3),
(1010, 15),
(1011, 25),
(1012, 3),
(1013, 1),
(1014, 22),
(1015, 3);

INSERT INTO gh_sp (id_gh, id_sp, so_luong) VALUES
(1000, 1000, 2),
(1000, 1001, 3),
(1001, 1002, 1),
(1001, 1003, 2),
(1002, 1004, 1),
(1002, 1005, 2),
(1003, 1006, 1),
(1003, 1007, 2),
(1004, 1008, 1),
(1004, 1009, 2),
(1005, 1010, 1),
(1005, 1011, 3),
(1006, 1012, 1),
(1006, 1013, 2),
(1007, 1014, 1),
(1007, 1015, 2),
(1008, 1016, 1),
(1008, 1017, 2),
(1009, 1018, 1),
(1009, 1019, 2),
(1010, 1020, 1),
(1010, 1021, 3),
(1011, 1022, 1),
(1011, 1021, 2),
(1012, 1022, 1),
(1014, 1007, 1),
(1015, 1007, 2);

INSERT INTO wishlist (id_wl, so_luong) VALUES
(1000, 3),
(1001, 2),
(1002, 4),
(1003, 1),
(1004, 2),
(1005, 3),
(1006, 1),
(1007, 2),
(1008, 3),
(1009, 4),
(1010, 3),
(1011, 2),
(1012, 4),
(1013, 1),
(1014, 2),
(1015, 3),
(1016, 2),
(1017, 4),
(1018, 1),
(1019, 2),
(1020, 3),
(1021, 4),
(1022, 2),
(1023, 3),
(1024, 1);

INSERT INTO wl_sp (id_wl, id_sp) VALUES
(1000, 1000),
(1000, 1001),
(1001, 1002),
(1001, 1003),
(1002, 1004),
(1002, 1005),
(1003, 1006),
(1003, 1007),
(1004, 1008),
(1004, 1009),
(1005, 1010),
(1005, 1011),
(1006, 1012),
(1006, 1013),
(1007, 1014),
(1008, 1015),
(1008, 1016),
(1009, 1017),
(1009, 1018),
(1010, 1019),
(1010, 1020),
(1011, 1021),
(1011, 1022),
(1012, 1021),
(1012, 1022);

SET SQL_SAFE_UPDATES = 1;