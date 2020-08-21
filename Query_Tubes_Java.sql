create database Petshop;
use Petshop;
drop database Petshop;
/*Tabel Pelanggan*/
create table Pelanggan
(kd_pelanggan varchar (10) primary key,nm_pelanggan varchar (50),JK enum('P','L'), alamat text ,
 no_telp bigint );
/*ENGINE=MYISAM*
alter table Pelanggan change kd_pelanggan kd_pelanggan varchar (10) NOT NULL;
insert into Pelanggan values ('P1','Bacoo','L','Makassar','3434');
drop table Pelanggan;*/

/*Tabel data Hewan*/
create table Data_hewan
(kd_hewan varchar (10) primary key,kd_pelanggan varchar (10),foreign key (kd_pelanggan) references Pelanggan (kd_pelanggan),
 nm_hewan varchar (50),
 Jenis_Hewan varchar (50), berat int,kategori_hewan enum ('Besar','Kecil'));

/*Tabel Paket*/
create table Paket 
(kd_paket varchar (10) primary key,kd_hewan varchar (10),nm_paket enum ('PaketA','PaketB','WP'),
Perawatan enum ('Grooming','Vaksin','Vitamin','all','GR+V','GR+Vit','V+Vit','none'),
Harga_Paket bigint,
foreign key (kd_hewan) references Data_hewan (kd_hewan));

/*Tabel data Penitipan*/
create table Data_Penitipan
(kd_penitipan varchar (10) primary key,kd_hewan varchar (10),
tgl_penitipan date,
lama_penitipan int ,
kd_paket varchar (50), biaya_penitipan bigint,
foreign key(kd_hewan) references Data_hewan (kd_hewan),
foreign key (kd_paket) references paket (kd_paket));

drop table Data_penitipan;
alter table Data_Penitipan add

/*Tabel Kandang*/
create table Kandang
(no_kandang varchar (10) primary key,kd_hewan varchar(10), status enum ('terisi','kosong'),

 foreign key (kd_hewan) references Data_hewan (kd_hewan));
 
 
 /*Tabel Pembayaran*/
  create table Data_Pengembalian (kd_pengembalian varchar (20)primary key,kd_penitipan varchar (10),
kd_pelanggan varchar(10),
no_kandang varchar (10),
total_biaya bigint,tgl_ambil date,
 foreign key (kd_pelanggan) references Pelanggan (kd_pelanggan),
 foreign key(no_kandang) references Kandang (no_kandang),
 foreign key(kd_penitipan) references Data_penitipan (kd_penitipan));
 
 /*Tabel Admin*/
 CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

 drop table admin;
--
-- Dumping data untuk tabel `admin`
--
 
INSERT INTO `admin` (`id`, `username`, `password`) VALUES
(1, 'admin', '12345');






create view total as select (Data_Penitipan.lama_penitipan * Data_Penitipan.Biaya_penitipan) + Paket.Harga_Paket as TolBi 
from Data_Penitipan,Paket where Data_Penitipan.kd_paket = Paket.kd_paket;

select * from total;

create view detail_costumer as select Pelanggan.nm_pelanggan,Data_hewan.nm_hewan,Data_hewan.Jenis_Hewan,Paket.nm_paket,Paket.Perawatan,
Kandang.no_kandang,Data_Penitipan.tgl_penitipan
from Pelanggan,Data_hewan,Paket,Kandang,Data_Penitipan
where Pelanggan.kd_pelanggan=Data_hewan.kd_pelanggan and Paket.kd_paket=Data_Penitipan.kd_paket and Data_hewan.kd_hewan=Kandang.kd_hewan;
select*from detail_costumer;

drop view detail_costumer;