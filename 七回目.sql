/*学籍番号：
氏　　名：
--------------------------------------------------
・学籍番号と氏名を入力してください
・SQL文を入力し提出してください
--------------------------------------------------

問1　下記4テーブルを作成する
　　　外部キー制約は、表制約で指定すること*/


/*顧客表【customer】*/
CREATE TABLE customer (
    cust_code CHAR(3) PRIMARY KEY,
    cust_name VARCHAR(30) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    birthday DATE,
    flg INTEGER DEFAULT 1
);


/*区分表【category】*/
CREATE TABLE category (
    c_code CHAR(1) PRIMARY KEY,
    c_name VARCHAR(20)
);


/*商品表【goods】*/
CREATE TABLE goods (
    g_code CHAR(4) PRIMARY KEY,
    g_name VARCHAR(30) NOT NULL,
    c_code CHAR(1),
    price INTEGER CHECK (price > 0),
    FOREIGN KEY (c_code) REFERENCES category(c_code)
);


/*受注表【orders】*/
CREATE TABLE orders (
    o_no CHAR(5) PRIMARY KEY,
    cust_code CHAR(3),
    g_code CHAR(4),
    number INTEGER NOT NULL,
    o_day CHAR(8),
    FOREIGN KEY (cust_code) REFERENCES customer(cust_code),
    FOREIGN KEY (g_code) REFERENCES goods(g_code)
);


/*問2　問1のテーブル作成順を答えなさい*/
-- 1. 顧客表【customer】
-- 2. 区分表【category】
-- 3. 商品表【goods】
-- 4. 受注表【orders】