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
    顧客番号 VARCHAR(4) PRIMARY KEY,
    顧客名 VARCHAR(50) NOT NULL,
    電話番号 VARCHAR(15),
    住所 VARCHAR(100)
);


/*区分表【category】*/
CREATE TABLE category (
    区分コード VARCHAR(3) PRIMARY KEY,
    区分名 VARCHAR(50) NOT NULL
);


/*商品表【goods】*/
CREATE TABLE goods (
    商品コード VARCHAR(5) PRIMARY KEY,
    商品名 VARCHAR(50) NOT NULL,
    単価 DECIMAL(10, 2) NOT NULL,
    区分コード VARCHAR(3),
    FOREIGN KEY (区分コード) REFERENCES category(区分コード)
);


/*受注表【orders】*/
CREATE TABLE orders (
    受注番号 VARCHAR(5) PRIMARY KEY,
    受注年月日 DATE NOT NULL,
    顧客番号 VARCHAR(4),
    受注合計 DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (顧客番号) REFERENCES customer(顧客番号)
);




/*問2　問1のテーブル作成順を答えなさい*/
-- 1. 顧客表【customer】
-- 2. 区分表【category】
-- 3. 商品表【goods】
-- 4. 受注表【orders】