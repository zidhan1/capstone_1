CREATE DATABASE IF NOT EXISTS rsud;

USE rsud;

CREATE TABLE pasien (
    no_rm VARCHAR(15) NOT NULL UNIQUE,
    nama VARCHAR(30) NOT NULL,
    jenis_kelamin CHAR(1) NOT NULL,
    tanggal_lahir DATE NOT NULL,
    berat_badan FLOAT NOT NULL,
    tinggi_badan FLOAT NOT NULL,
    PRIMARY KEY (no_rm)
);

CREATE TABLE tanda_vital (
    id_vital INT NOT NULL auto_increment,
    no_rm VARCHAR(30) NOT NULL,
    tekanan_darah FLOAT NOT NULL,
    suhu_tubuh FLOAT NOT NULL,
    PRIMARY KEY (id_vital),
    FOREIGN KEY (no_rm) REFERENCES pasien (no_rm) ON DELETE CASCADE
);

INSERT INTO
    pasien (
        no_rm,
        nama,
        jenis_kelamin,
        tanggal_lahir,
        berat_badan,
        tinggi_badan
    )
VALUES (
        'RM020326001',
        'Renaldy Fatikhur',
        'L',
        '2000-03-15',
        68.5,
        172.0
    ),
    (
        'RM020326002',
        'Siti Nurhaliza',
        'P',
        '1995-07-22',
        52.0,
        158.0
    ),
    (
        'RM020326003',
        'Budi Prasetyo',
        'L',
        '1988-11-05',
        75.0,
        178.5
    ),
    (
        'RM020326004',
        'Dewi Kusumawati',
        'P',
        '2001-01-30',
        48.5,
        155.0
    ),
    (
        'RM020326005',
        'Ahmad Zulkarnain',
        'L',
        '1993-04-18',
        82.0,
        180.0
    ),
    (
        'RM020326006',
        'Fitria Ramadhani',
        'P',
        '1998-09-12',
        55.5,
        161.5
    ),
    (
        'RM020326007',
        'Hendra Gunawan',
        'L',
        '1985-06-25',
        90.0,
        175.0
    ),
    (
        'RM020326008',
        'Nurul Hidayah',
        'P',
        '2003-02-08',
        45.0,
        152.0
    ),
    (
        'RM020326009',
        'Rizky Maulana',
        'L',
        '1997-12-19',
        71.5,
        169.0
    ),
    (
        'RM020326010',
        'Anggraini Putri',
        'P',
        '1990-08-03',
        58.0,
        163.5
    );

INSERT INTO
    tanda_vital (
        id_vital,
        no_rm,
        tekanan_darah,
        suhu_tubuh
    )
VALUES (
        1,
        'RM020326001',
        120.80,
        36.5
    ),
    (
        2,
        'RM020326002',
        110.70,
        36.8
    ),
    (
        3,
        'RM020326003',
        130.85,
        37.0
    ),
    (
        4,
        'RM020326004',
        115.75,
        36.6
    ),
    (
        5,
        'RM020326005',
        140.90,
        37.2
    ),
    (
        6,
        'RM020326006',
        118.78,
        36.9
    ),
    (
        7,
        'RM020326007',
        150.95,
        37.5
    ),
    (
        8,
        'RM020326008',
        108.68,
        36.4
    ),
    (
        9,
        'RM020326009',
        125.82,
        36.7
    ),
    (
        10,
        'RM020326010',
        112.72,
        36.3
    );