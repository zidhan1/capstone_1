import mysql.connector as mysql
from mysql.connector import Error
from datetime import datetime
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

def mysqlConnect():
    try:
        connection = mysql.connect(
            host='localhost',
            user='root',
            password='12345678',
            database='rsud'
        )
        if connection.is_connected():
            print("Connected to MySQL database")
        return connection
    except Error as e:
        print(f"Error: {e}")

def menu():
    print("=====================================")
    print("Selamat datang di program Rumah Sakit:")
    print("1. Melihat data pasien")
    print("2. Menambah data pasien")
    print("3. Mengupdate data pasien")
    print("4. Menghapus data pasien")
    print("5. Melihat statistik data")
    print("6. Tampilkan visualisasi data")
    print("7. Keluar program")
    print("=====================================")

    choosen_menu = input("Masukkan pilihan menu: ")

    return choosen_menu

def readData(cursor):
    cursor.execute("SELECT ps.*, tv.tekanan_darah, tv.suhu_tubuh  FROM pasien ps INNER JOIN tanda_vital tv ON tv.no_rm = ps.no_rm")
    patient_data = cursor.fetchall()
    
    print(f"{'Rekam Medis':<15} {'Nama':<20} {'JK':<6} {'Tanggal Lahir':<20} {'BB':<6} {'TB':<6} {'darah':<6} {'Suhu Tubuh':<6}")
    print("-" * 100) 

    iterator = 0
    for value in patient_data:
        print(f"{iterator + 1}. {str(value[0]):<15} {str(value[1]):<20} {str(value[2]):<6} {str(value[3]):<15} {str(value[4]):<6} {str(value[5]):<8} {str(value[6]):<7} {str(value[7]):<7}")
        iterator += 1

def createRMNumber(no_rm):
    split_rm = list(no_rm)
    if(int(split_rm[9]) == 0):
        return f'RM02032600{(int(split_rm[10]) + 1)}'
    else:
        num = f'{split_rm[9]}{split_rm[10]}'
        num_int = int(num)
        return f'RM0203260{(num_int + 1)}'

def addData(cursor, conn):
    cursor.execute("SELECT no_rm FROM pasien ORDER BY no_rm DESC")
    fetch_norm = cursor.fetchone()

    no_rm = createRMNumber(fetch_norm[0])
    nama = input("Masukkan nama pasien: ")
    jk = input("Masukkan jenis kelamin (L/P): ")
    tgl_lahir = input("Masukkan Tanggal Lahir (tahun-bulan-tanggal): ")
    bb = input("Masukkan berat badan: ")
    tb = input("Masukkan tinggi badan: ")
    td = input("Masukkan tekanan darah: ")
    st = input("Masukkan suhu tubuh: ")

    sql = "INSERT INTO pasien (no_rm, nama, jenis_kelamin, tanggal_lahir, berat_badan, tinggi_badan) VALUES (%s, %s, %s, %s, %s, %s)"
    values = (no_rm, nama, jk, tgl_lahir, float(bb), float(tb))
    
    cursor.execute(sql, values)

    conn.commit()

    sql = "INSERT INTO tanda_vital (no_rm, tekanan_darah, suhu_tubuh) VALUES (%s, %s, %s)"
    values = (no_rm, float(td), float(st))

    cursor.execute(sql, values)

    conn.commit()

    print(f"----- Data pasien berhasil ditambahkan -----")

def updateData(cursor, conn):
    readData(cursor);
    choosen_rm = input("Masukkan nomor data yang ingin diubah: ")

    cursor.execute("SELECT no_rm FROM pasien ORDER BY no_rm ASC")

    data = cursor.fetchall();
    no_rm = data[int(choosen_rm) - 1][0];

    nama = input("Masukkan nama pasien: ")
    jk = input("Masukkan jenis kelamin (L/P): ")
    tgl_lahir = input("Masukkan Tanggal Lahir (tahun-bulan-tanggal): ")
    bb = input("Masukkan berat badan: ")
    tb = input("Masukkan tinggi badan: ")
    td = input("Masukkan tekanan darah: ")
    st = input("Masukkan suhu tubuh: ")

    sql = "UPDATE pasien SET nama = %s, jenis_kelamin = %s, tanggal_lahir = %s, berat_badan = %s, tinggi_badan = %s WHERE no_rm = %s"  
    val = (nama, jk, tgl_lahir, float(bb), float(tb), no_rm) 

    cursor.execute(sql, val)
    conn.commit()

    sql = "UPDATE tanda_vital SET tekanan_darah = %s, suhu_tubuh = %s WHERE no_rm = %s"  
    val = (td, st, no_rm) 

    cursor.execute(sql, val)
    conn.commit()

    print(f"----- Data pasien {no_rm} berhasil diupdate -----")

def deleteData(cursor, conn):
    readData(cursor);
    choosen_rm = input("Masukkan nomor data yang ingin dihapus: ")

    cursor.execute("SELECT no_rm FROM pasien ORDER BY no_rm ASC")

    data = cursor.fetchall();
    no_rm = data[int(choosen_rm) - 1][0];

    sql = f"DELETE FROM pasien WHERE no_rm = '{no_rm}'"

    cursor.execute(sql)
    conn.commit()

    print(f"----- Data pasien {no_rm} berhasil dihapus -----")

def analysisData(cursor):
    cursor.execute("SELECT ps.*, tv.tekanan_darah, tv.suhu_tubuh  FROM pasien ps INNER JOIN tanda_vital tv ON tv.no_rm = ps.no_rm")
    data = cursor.fetchall()

    df = pd.DataFrame(data, columns=['No RM', 'Nama', 'JK', "Tanggal Lahir", "BB", "TB", "Darah", "Suhu"])
    
    current_date = datetime.now()
    df["Tanggal Lahir"] = pd.to_datetime(df["Tanggal Lahir"])
    df["Age"] = (pd.to_datetime(current_date) - df["Tanggal Lahir"]).dt.days / 365.25
    df["Age"] = df["Age"].astype(int)
    
    def umur(age):
        if age <= 18:
            return 'Remaja'
        elif age <= 35:
            return "Remaja Dewasa"
        elif age > 35:
            return "Dewasa Matang"

    df["Kategori Umur"] = df["Age"].apply(umur)

    data = df[['JK', 'Kategori Umur', 'Darah', 'Suhu']]

    mean_data = data.pivot_table(index="Kategori Umur", columns="JK", aggfunc="mean", values=["Darah", "Suhu"])
    print("Berikut ini adalah rata-rata tekanan darah dan suhu tubuh pasien:")
    print(mean_data)

def dataVisualization(cursor):
    cursor.execute("SELECT jenis_kelamin, COUNT(no_rm) FROM pasien GROUP BY jenis_kelamin")
    data = cursor.fetchall()

    arr_jk = np.array(data)
    
    labels = ['Laki-laki', 'Perempuan']
    sizes = [arr_jk[0, 1], arr_jk[1, 1]]

    plt.pie(sizes, labels=labels, autopct='%1.1f%%')

    plt.title("Persentase Data Pasien Berdasarkan Jenis kelamin")
    plt.show()

def main():
    # Koneksikan ke database
    conn = mysqlConnect()
    cursor = conn.cursor(buffered=True)

    while(True):
        # Ambil pilihan menu user
        choosen_menu = menu();

        if choosen_menu == "1":
            try:
                readData(cursor)
                continue
            except:
                print("----- Gagal menampilkan data -----")
                continue
        elif choosen_menu == "2":
            try:
                addData(cursor, conn)
                continue
            except:
                print("----- Gagal menambahkan data pasien -----")
                continue
        elif choosen_menu == "3":
            try:
                updateData(cursor, conn)
                continue
            except:
                print("----- Gagal mengupdate data pasien -----")
                continue
        elif choosen_menu == "4":
            try:
                deleteData(cursor, conn)
                continue
            except:
                print('----- Gagal menghapus data pasien -----')
                continue
        elif choosen_menu == "5":
            try:
                analysisData(cursor)
                continue
            except:
                print('----- Gagal Analysis data -----')
                continue
        elif choosen_menu == "6":
            dataVisualization(cursor)
        elif choosen_menu == "7":
            exit()
        else :
            print("Tidak ada menu yang sesuai")

main()
